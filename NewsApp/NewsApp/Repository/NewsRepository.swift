//
//  Repository.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation

protocol NewsRepositoryProtocol {
    func getNews(completion: @escaping (ResultWithError<ApiPost>) -> ())
    func getNewsSearchable(qInTitle: String, sortBy: String, completion: @escaping (ResultWithError<ApiPost>) -> ())
    //    func getTop(country: String) -> ResultWithError<ApiPost>
}

final class NewsRepository: NewsRepositoryProtocol {
    private let router = Router<NewsAPI>()
    
    func getNews(completion: @escaping (ResultWithError<ApiPost>) -> ()) {
        router.request(.getNews, completion: {result in
            completion(result)
        })
    }
    
    func getNewsSearchable(qInTitle: String, sortBy: String, completion: @escaping (ResultWithError<ApiPost>) -> ()) {
        router.request(.getNewsSearchable(qInTitle: qInTitle, sortBy: sortBy), completion: {
            result in
            completion(result)
        })
    }
    //
    //    func getTop(country: String) -> ResultWithError<ApiPost> {
    //        //router.request(.getTop(country: country))
    //    }
}
