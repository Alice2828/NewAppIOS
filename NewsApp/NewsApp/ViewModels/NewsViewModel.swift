//
//  ViewModel.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation

final class NewsViewModel: ObservableObject {
    @Published var news: [Article] = [Article]()
    private var newsRepo: NewsRepositoryProtocol
    
    var isLoading: Bool = false {
        didSet {
            //self.updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            //self.showAlertClosure?()
        }
    }
    init(newsRepo:NewsRepositoryProtocol = NewsRepository()) {
        self.newsRepo = newsRepo
    }
    
    func getNews(qInTitle: String, sortBy: String,  apiKey: String) -> Observable<ResultWithError<ApiPost>?>{
        self.isLoading = true
        
        return newsRepo.getNews(qInTitle: qInTitle, sortBy: sortBy, apiKey: apiKey)
    }
    
    //    func removeContact(offsets: IndexSet){
    //        people.remove(atOffsets: offsets)
    //    }
    //
    //    func removeContact(index: Int){
    //        people.remove(at: index)
    //    }
    //
    //    func checkEmpty() -> Bool{
    //        return people.isEmpty
    //    }
    //
    //    func getIndexOf(person: Person) -> Int{
    //        return people.firstIndex{ $0 == person } ?? 0
    //    }
    //
    //    func addContact(person: Person){
    //        people.append(person)
    //    }
}
