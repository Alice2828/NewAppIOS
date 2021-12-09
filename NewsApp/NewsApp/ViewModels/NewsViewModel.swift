//
//  ViewModel.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation
import CoreData
import SwiftUI

final class NewsViewModel: ObservableObject {
    private var newsRepo: NewsRepositoryProtocol
    @Published var topNews: [Article] = [Article]()
    @Published var searchedNews: [Article] = [Article]()
    @FetchRequest(
        entity: LikedArticle.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LikedArticle.articleId, ascending: true)
        ]
    )
    var likes: FetchedResults<LikedArticle>
    
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
    }
    
    func getNewsSearchable(){
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
    
    func saveOrDeleteLike(context: NSManagedObjectContext, id: String){
        print("ID LALA \(id)")
        if (likes.contains(where: {$0.articleId == id})){
            if let like = likes.first(where: {$0.articleId == id}){
                context.delete(like)
            }
        }
        else{
            let entity = LikedArticle(context: context)
            entity.articleId = id
            entity.userId = "kek"
            print("baddd")
        }
        do{
            try context.save()
            print("success")
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
}
