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
import Combine

class LikesViewModel: ObservableObject {
    let coreDataStore: CoreDataStoring!
    var bag: [AnyCancellable] = []
    @Published var likesObservable: [LikedArticle] = [LikedArticle]()
    
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded
    }
    @Published private(set) var state = State.idle
    
    init(coreDataStore: CoreDataStoring) {
        self.coreDataStore = coreDataStore
    }
    
    func shareArticle(article: Article){
        
    }
    
    func saveOrDeleteLike2(article: Article){deleteAll()}
    func saveOrDeleteLike(article: Article){
        if (likesObservable.contains(where: {$0.title == article.title})){
            deleteLike(article: article)
        }
        else {saveLike(article: article)}
    }
    
    func saveLike(article: Article){
        let action: Action = { [self] in
            let entity: LikedArticle = coreDataStore.createEntity()
            entity.userName = Auth.auth().currentUser?.email
            entity.publishedAt = article.publishedAt
            entity.descrip = article.description
            entity.url = article.url
            entity.urlToImage = article.urlToImage
            entity.title = article.title
            entity.content = article.content
            entity.author = article.author
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { [self] success in
                if success {
                    fetch()
                }
            }
            .store(in: &bag)
    }
    
    func fetch() {
        let request = NSFetchRequest<LikedArticle>(entityName: LikedArticle.entityName)
        
        coreDataStore
            .publicher(fetch: request)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { [self] articles in
                likesObservable = articles
                print("HIHI HIHI \(likesObservable)")
            }
            .store(in: &bag)
    }
    
    func deleteLike(article: Article) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: LikedArticle.entityName)
        request.predicate = NSPredicate(format: "title LIKE[cd] %@", article.title!)
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { [self] _ in
                fetch()
                print("HIHI HIHI \(likesObservable)")
            }
            .store(in: &bag)
        
    }
    
    func deleteAllLikes() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: LikedArticle.entityName)
        request.predicate = NSPredicate(format: "first_name LIKE[cd] %@", "Deda")
        coreDataStore
            .publicher(delete: request)
            .sink { completion in
                if case .failure(let error) = completion {
                    //message = error.localizedDescription
                }
            } receiveValue: { _ in
                //                   message = "Deleting entities succeeded"
                //                   number_of_persons = 0
            }
            .store(in: &bag)
        
    }
    
    func deleteAll(){
        let storeContainer = PersistentCloudKitContainer.persistentContainer.persistentStoreCoordinator
        
        // Delete each existing persistent store
        do {for store in storeContainer.persistentStores {
            try storeContainer.destroyPersistentStore(
                at: store.url!,
                ofType: store.type,
                options: nil
            )
        }
        }
        catch{}
        
        // Re-create the persistent container
        PersistentCloudKitContainer.persistentContainer = NSPersistentContainer(
            name: "NewsApp" // the name of
            // a .xcdatamodeld file
        )
        
        // Calling loadPersistentStores will re-create the
        // persistent stores
        PersistentCloudKitContainer.persistentContainer.loadPersistentStores {
            (store, error) in
            // Handle errors
        }
    }
}
