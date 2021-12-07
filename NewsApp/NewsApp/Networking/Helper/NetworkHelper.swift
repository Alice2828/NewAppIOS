//
//  NetworkHelper.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation

typealias ResultWithError<T> = Result<T, Error>

struct NetworkHelper {
    static let shared = NetworkHelper()
    private init() {}

    func handle<T: Decodable>(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ResultWithError<T> {
        var result: ResultWithError<T> = .failure(NetworkResponseError.failed)
        if let error = error {
            result = .failure(error)
            print("wtf")
            return result
        }

        guard let response = response as? HTTPURLResponse else {
            result = .failure(NetworkResponseError.httpURLResponseCastFailed)
            print("wtf 2")
            return result
        }
        switch handleNetworkResponse(response) {
        case .success:
            guard let responseData = data else {
                print("wtf 3")
                result = .failure(NetworkResponseError.noData)
                return result
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                print(jsonData)
                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                result = .success(apiResponse)
            } catch {
                print(error)
                print("wtf 4")
                result = .failure(NetworkResponseError.unableToDecode)
            }
        case .failure(let networkFailureError):
            print("wtf 5")
            result = .failure(networkFailureError)
        }
        return result
    }

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> ResultWithError<Void> {
        switch response.statusCode {
        case 200...299: return .success(())
        case 401...500: return .failure(NetworkResponseError.authenticationError)
        case 501...599: return .failure(NetworkResponseError.badRequest)
        case 600: return .failure(NetworkResponseError.outdated)
        default: return .failure(NetworkResponseError.failed)
        }
    }
}
