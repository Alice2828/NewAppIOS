//
//  SearchableNewsViewModel.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 08.12.2021.
//

import Foundation

final class SearchableNewsViewModel: ObservableObject {
    private var newsRepo: NewsRepositoryProtocol
    
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([Article])
    }
    @Published private(set) var state = State.idle
    
    init(newsRepo: NewsRepositoryProtocol = NewsRepository()) {
        self.newsRepo = newsRepo
    }
    
    func getNews(){
        state = .loading
        newsRepo.getNews(){ [weak self] result in
            switch result {
            case .success(let apiPost):
                DispatchQueue.main.async {self?.state = .loaded(apiPost.articles ?? [Article]())}
            case .failure(let error):
                DispatchQueue.main.async {self?.state = .failed(error)}
            }
        }
    }
    
    func getNewsSearchable(){
        state = .loading
        newsRepo.getNewsSearchable(qInTitle: "bitcoin"){ [weak self] result in
            switch result {
            case .success(let apiPost):
                DispatchQueue.main.async { self?.state = .loaded(apiPost.articles ?? [Article]())}
            case .failure(let error):
                DispatchQueue.main.async { self?.state = .failed(error)}
            }
        }
    }
}