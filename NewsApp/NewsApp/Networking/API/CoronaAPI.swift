//
//  CoronaAPI.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import Foundation

enum CoronaAPI {
    case getKz
    case getTotal
}

extension CoronaAPI: EndPointType {
    var baseURL: URL {
        URL(string: "https://api.covid19api.com")!
    }
    
    var path: String {
        switch self {
        case .getKz:
            return "dayone/country/kazakhstan"
        case .getTotal:
            return "summary"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getKz,
                .getTotal:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getKz:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: [:])
        case .getTotal:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: [:])
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getKz,
                .getTotal:
            return [:]
        }
    }
}
