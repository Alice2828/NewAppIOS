//
//  Repository.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation

protocol NewsRepositoryProtocol {
    func getNews(qInTitle: String, sortBy: String,  apiKey: String) -> NetworkResult<ApiPost>
    func getTop(country: String, apiKey: String) -> NetworkResult<ApiPost>
}

final class NewsRepository: NewsRepositoryProtocol {
    private let router = Router<NewsAPI>()

    func getNews(qInTitle: String, sortBy: String,  apiKey: String) -> NetworkResult<ApiPost> {
        router.request(.getNews(qInTitle: qInTitle, sortBy: sortBy, apiKey: apiKey))
    }

    func getTop(country: String, apiKey: String) -> NetworkResult<ApiPost> {
        router.request(.getTop(country: country, apiKey: apiKey))
    }
}
