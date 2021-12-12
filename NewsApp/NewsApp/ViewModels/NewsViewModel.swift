//
//  ViewModel.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation
import CoreData
import SwiftUI
import FirebaseAuth

class NewsViewModel: ObservableObject {
    private var newsRepo: NewsRepositoryProtocol
    @Published var topNews: [Article] = [Article]()
    @Published var searchedNews: [Article] = [Article]()
    @Published var searchedText: String = "bitcoin"
    var context: NSManagedObjectContext?
    //    @FetchRequest(
    //        entity: LikedArticle.entity(),
    //        sortDescriptors: [
    //            NSSortDescriptor(keyPath: \LikedArticle.articleId, ascending: true)
    //        ]
    //    )
    //    var likes: FetchedResults<LikedArticle>
    @FetchRequest private var likes: FetchedResults<LikedArticle>
    @Published var likesIds: [String?] = [String?]()
    
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded
    }
    @Published private(set) var topState = State.idle
    @Published private(set) var searchState = State.idle
    
    init(newsRepo: NewsRepositoryProtocol = NewsRepository()) {
        self.newsRepo = newsRepo
        
        let fetchRequest: NSFetchRequest<LikedArticle> = LikedArticle.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \LikedArticle.articleId, ascending: true)]
        //fetchRequest.predicate = NSPredicate(value: true)
        
        do {
            self._likes = FetchRequest(fetchRequest: fetchRequest)
            let likesFromCore = try context?.fetch(fetchRequest)
            print("HIHI \(likesFromCore)")
            self.likesIds = likesFromCore?.map({$0.articleId}) ?? [String]()
        } catch {
            fatalError("Uh, fetch problem...")
        }
    }
    
    func getNewsSearchableDefault(){
        searchState = .loading
        newsRepo.getNewsSearchable(qInTitle: "bitcoin"){ [weak self] result in
            switch result {
            case .success(let apiPost):
                DispatchQueue.main.async {
                    self?.searchState = .loaded
                    self?.searchedNews = apiPost.articles ?? [Article]()
                }
            case .failure(let error):
                DispatchQueue.main.async { self?.searchState = .failed(error)}
            }
        }
    }
    
    func getNewsSearchable(){
        searchState = .loading
        newsRepo.getNewsSearchable(qInTitle: searchedText){ [weak self] result in
            switch result {
            case .success(let apiPost):
                DispatchQueue.main.async {
                    self?.searchState = .loaded
                    self?.searchedNews = apiPost.articles ?? [Article]()
                }
            case .failure(let error):
                DispatchQueue.main.async { self?.searchState = .failed(error)}
            }
        }
    }
    
    func getTop(){
        topState = .loading
        newsRepo.getTop{ [weak self] result in
            switch result {
            case .success(let apiPost):
                DispatchQueue.main.async {
                    self?.topState = .loaded
                    self?.topNews = apiPost.articles ?? [Article]()}
            case .failure(let error):
                DispatchQueue.main.async { self?.topState = .failed(error)}
            }
        }
    }
    
    func saveOrDeleteLike(id: String){
        print("ID LALA \(id)")
        if (likes.contains(where: {$0.articleId == id}) || likesIds.contains(where: {$0 == id})){
            if let like = likes.first(where: {$0.articleId == id}){
                context?.delete(like)
            }
            context?.perform{ [self] in
                do{
                    try context?.save()
                    if let index = self.likesIds.firstIndex(of: id){
                        self.likesIds.remove(at: index)
                        print("success")
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        else{
            let entity = LikedArticle(context: context!)
            entity.articleId = id
            entity.userName = Auth.auth().currentUser?.email
            context?.perform{ [self] in
                do{
                    try context?.save()
                    self.likesIds.append(id)
                    print("success")
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
