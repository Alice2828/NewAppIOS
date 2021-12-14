//
//  Router.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation

typealias NetworkRouterCompletion<T: Decodable> = (_ result: ResultWithError<T>) -> ()

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request<T: Decodable>(_ route: EndPoint,  completion: @escaping NetworkRouterCompletion<T>)
    func cancel()
}

final class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?

//    func request<T: Decodable>(_ route: EndPoint) -> NetworkResult<T> {
//        let observable: MutableObservable<ResultWithError<T>?> = .init(nil)
//        let session = URLSession.shared
//        do {
//            let request = try buildRequest(from: route)
//            NetworkLogger.log(request: request)
//            task = session.dataTask(with: request) { data, response, error in
//                NetworkLogger.log(response: response)
//                observable.wrappedValue = NetworkHelper.shared.handle(data, response, error)
//            }
//        } catch {
//            observable.wrappedValue = .failure(error)
//        }
//        task?.resume()
//        return observable
//    }
    func request<T: Decodable>(_ route: EndPoint, completion: @escaping NetworkRouterCompletion<T>){
        // let observable: MutableObservable<ResultWithError<T>?> = .init(nil)
        var res: ResultWithError<T> = .failure(NetworkResponseError.failed)
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request) { data, response, error in
                NetworkLogger.log(response: response)
                res = NetworkHelper.shared.handle(data, response, error)
                completion(res)
            }
        } catch {
            res = .failure(error)
            completion(res)
        }
        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }

    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(
            url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let bodyEncoding, let urlParameters, let additionalHeaders):
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            print(request)
            try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }

    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
