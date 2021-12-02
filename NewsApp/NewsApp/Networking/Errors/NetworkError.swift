//
//  NetworkError.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation

enum NetworkError: Error {
    case parametersNil
    case encodingFailed
    case missingURL

    var localizedDescription: String {
        switch self {
        case .parametersNil: return "Parameters were nil."
        case .encodingFailed: return "Parameter encoding failed."
        case .missingURL: return "URL is nil."
        }
    }
}
