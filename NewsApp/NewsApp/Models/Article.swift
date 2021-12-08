//
//  Article.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation

struct Article: Identifiable, Equatable, Hashable, Codable{
    var id: String? {
        didSet {
            if id == nil
            {
                id = randomString(length: 5)
            }
        }
    }
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title && lhs.content == rhs.content
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

