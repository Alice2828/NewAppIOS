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
}
