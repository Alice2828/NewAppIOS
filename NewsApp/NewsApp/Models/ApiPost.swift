//
//  ApiPost.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 02.12.2021.
//

import Foundation

struct ApiPost: Codable{
   
    var status: String
    var totalResults: Int
    var articles: [Article]
}

