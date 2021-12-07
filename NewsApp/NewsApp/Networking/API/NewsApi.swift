//
//  NewsApi.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation
let API_KEY = "b0fe0f0da9634ed890cefa676654c7d8"

enum NewsAPI {
    case getNews
    case getNewsSearchable(qInTitle: String, sortBy: String)
    case getTop(country: String)
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
        case .getNewsSearchable:
            return "everything"
        case .getTop:
            return "top-headlines"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getNews,
             .getNewsSearchable,
             .getTop:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getNews:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlAndJsonEncoding, urlParameters: ["apiKey": API_KEY])
        case .getNewsSearchable(let qInTitle, let sortBy):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["qInTitle": qInTitle, "sortBy": sortBy, "apiKey": API_KEY])
        case .getTop(let country):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlAndJsonEncoding, urlParameters: ["country": country, "apiKey": API_KEY])
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getNews,
             .getNewsSearchable,
             .getTop:
            return [:]
        }
    }
}
