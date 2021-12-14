//
//  LikesListView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 14.12.2021.
//

import Foundation
import SwiftUI

struct LikesListView: View {
    @EnvironmentObject var likesViewModel: LikesViewModel
    
    var body: some View {
        ZStack{
            List {
                ForEach(likesViewModel.likesObservable, id: \.self) { article in
                    LikedArticleRow(article: article)
                }
                
            }
        }
    }
}

//struct NewsArticleRow: View {
//    @State var article: Article
//
//    var body: some View {
//        NewsCardView(article: $article)
//            .onAppear(perform: {print("ID LALA LA \(article.id)")})
//    }
//}
//
//struct LikedArticleRow: View {
//    @State var article: LikedArticle
//
//    var body: some View {
//        LikedNewsCardView(article: $article)
//            .onAppear(perform: {print("ID LALA LA \(article.id)")})
//    }
//}
