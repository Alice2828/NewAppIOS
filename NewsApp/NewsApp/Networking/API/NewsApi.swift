//
//  NewsApi.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation
enum NewsAPI {
    case getNews(qInTitle: String, sortBy: String,  apiKey: String)
    case getTop(country: String, apiKey: String)
    //case getSources()
}

extension NewsAPI: EndPointType {
    var baseURL: URL {
        URL(string: "https://newsapi.org/v2/")!
    }

    var path: String {
        switch self {
        case .getNews:
            return "everything"
        case .getTop:
            return "top-headlines"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getNews,
             .getTop:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getNews(let qInTitle, let sortBy,  let apiKey):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: ["qInTitle": qInTitle, "sortBy": sortBy, "apiKey": apiKey])
        case .getTop(let country, let apiKey):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: ["country": country, "apiKey": apiKey ])
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getNews,
             .getTop:
            return [:]
        }
    }
}
