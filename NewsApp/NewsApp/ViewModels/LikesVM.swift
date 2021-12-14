//
//  LikesVM.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 14.12.2021.
//

import Foundation
import CoreData
import SwiftUI
import FirebaseAuth

class LikesViewModel: ObservableObject {
    var context: NSManagedObjectContext?
    //    @FetchRequest(
    //        entity: LikedArticle.entity(),
    //        sortDescriptors: [
    //            NSSortDescriptor(keyPath: \LikedArticle.articleId, ascending: true)
    //        ]
    //    )
    //    var likes: FetchedResults<LikedArticle>
    @FetchRequest private var likes: FetchedResults<LikedArticle>
    @Published var likesObservable: [LikedArticle] = [LikedArticle]()
    
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded
    }
    @Published private(set) var state = State.idle
    
    init() {
        let fetchRequest: NSFetchRequest<LikedArticle> = LikedArticle.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \LikedArticle.articleId, ascending: true)]
        fetchRequest.predicate = NSPredicate(value: true)
        
        do {
            self._likes = FetchRequest(fetchRequest: fetchRequest)
            let likesFromCore = try context?.fetch(fetchRequest)
            print("HIHI \(String(describing: likesFromCore))")
            self.likesObservable = likesFromCore ?? [LikedArticle]()
        } catch {
            fatalError("Uh, fetch problem...")
        }
    }
    
    func fetchReq(){
        let fetchRequest: NSFetchRequest<LikedArticle> = LikedArticle.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \LikedArticle.articleId, ascending: true)]
        fetchRequest.predicate = NSPredicate(value: true)
        
        do {
            self._likes = FetchRequest(fetchRequest: fetchRequest)
            let likesFromCore = try context?.fetch(fetchRequest)
            print("HIHI \(String(describing: likesFromCore))")
            self.likesObservable = likesFromCore ?? [LikedArticle]()
        } catch {
            fatalError("Uh, fetch problem...")
        }
    }
    
    func saveOrDeleteLike(article: Article){
        print("ID LALA \(article.id)")
        print ("HIHI 1 \(context!)")
        if (likes.contains(where: {$0.articleId == article.articleId}) || likesObservable.contains(where: {$0.articleId == article.articleId})){
            if let like = likes.first(where: {$0.articleId == article.articleId}){
                context?.delete(like)
            }
            context?.perform{ [self] in
                do{
                    try context?.save()
                    if let index = self.likesObservable.firstIndex(where: {$0.articleId == article.id}){
                        self.likesObservable.remove(at: index)
                        print("success")
                    }
                    
                    //
                    let fetchRequest: NSFetchRequest<LikedArticle> = LikedArticle.fetchRequest()
                    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \LikedArticle.articleId, ascending: true)]
                    //fetchRequest.predicate = NSPredicate(value: true)
                    
                    do {
                        self._likes = FetchRequest(fetchRequest: fetchRequest)
                        let likesFromCore = try context?.fetch(fetchRequest)
                        print("HIHI \(likesFromCore)")
                        self.likesObservable = likesFromCore ?? [LikedArticle]()
                    } catch {
                        fatalError("Uh, fetch problem...")
                    }
                    //
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        else{
            let entity = LikedArticle(context: context!)
            entity.articleId = article.id
            entity.userName = Auth.auth().currentUser?.email
            entity.publishedAt = article.publishedAt
            entity.descrip = article.description
            entity.url = article.url
            entity.urlToImage = article.urlToImage
            entity.title = article.title
            entity.content = article.content
            entity.author = article.author
            context?.perform{ [self] in
                do{
                    try context?.save()
                    //self.likesObservable.append(LikedArticle())
                    print("success")
                    //
                    let fetchRequest: NSFetchRequest<LikedArticle> = LikedArticle.fetchRequest()
                    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \LikedArticle.articleId, ascending: true)]
                    //fetchRequest.predicate = NSPredicate(value: true)
                    
                    do {
                        self._likes = FetchRequest(fetchRequest: fetchRequest)
                        let likesFromCore = try context?.fetch(fetchRequest)
                        print("HIHI \(likesFromCore)")
                        self.likesObservable = likesFromCore ?? [LikedArticle]()
                    } catch {
                        fatalError("Uh, fetch problem...")
                    }
                    //
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
