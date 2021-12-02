//
//  Article.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation

struct Article: Identifiable, Equatable, Hashable, Codable{
    var id = UUID()
    
    var author: String
    var title: String
    var gender: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
    
    static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title && lhs.content == rhs.content
    }
}

