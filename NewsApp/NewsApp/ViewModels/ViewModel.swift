//
//  ViewModel.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var news: [Article] = [Article(author: "k",title: "k",gender: "k",description: "k",url: "k",urlToImage: "k",publishedAt: "k",content: "k")]
    
    
    
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
