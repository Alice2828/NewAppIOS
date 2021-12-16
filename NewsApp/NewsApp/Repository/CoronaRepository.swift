//
//  CoronaRepository.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import Foundation


protocol CoronaRepositoryProtocol {
    func getTotal(completion: @escaping (ResultWithError<General>) -> ())
    func getKz(completion: @escaping (ResultWithError<[DataCorona]>) -> ())
}

final class CoronaRepository: CoronaRepositoryProtocol {
    private let router = Router<CoronaAPI>()
    
    func getTotal(completion: @escaping (ResultWithError<General>) -> ()) {
        router.request(.getTotal, completion: {result in
            completion(result)
        })
    }
    
    func getKz(completion: @escaping (ResultWithError<[DataCorona]>) -> ()) {
        router.request(.getKz, completion: {result in
            completion(result)
        })
    }
}
