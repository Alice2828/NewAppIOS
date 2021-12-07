//
//  Repository.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation

protocol NewsRepositoryProtocol {
    func getNews(completion: @escaping (ResultWithError<ApiPost>) -> ())
    func getNewsSearchable(qInTitle: String, completion: @escaping (ResultWithError<ApiPost>) -> ())
    func getTop(completion: @escaping (ResultWithError<ApiPost>) -> ())
}

final class NewsRepository: NewsRepositoryProtocol {
    private let router = Router<NewsAPI>()
    
    func getNews(completion: @escaping (ResultWithError<ApiPost>) -> ()) {
        router.request(.getNews, completion: {result in
            completion(result)
        })
    }
    
    func getNewsSearchable(qInTitle: String, completion: @escaping (ResultWithError<ApiPost>) -> ()) {
        router.request(.getNewsSearchable(qInTitle: qInTitle), completion: {
            result in
            completion(result)
        })
    }
    
    func getTop(completion: @escaping (ResultWithError<ApiPost>) -> ()) {
        router.request(.getTop, completion: {
            result in
            completion(result)
        })
    }
}
