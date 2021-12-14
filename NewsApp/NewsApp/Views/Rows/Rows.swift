//
//  Rows.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 14.12.2021.
//

import Foundation
import SwiftUI

struct NewsArticleRow: View {
    @State var article: Article
    
    var body: some View {
        NewsCardView(article: $article)
    }
}

struct LikedArticleRow: View {
    @State var article: LikedArticle
    
    var body: some View {
        LikedNewsCardView(article: $article)
    }
}
