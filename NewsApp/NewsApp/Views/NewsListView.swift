//
//  NewsListView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 07.12.2021.
//

import SwiftUI

struct NewsList: View {
    @ObservedObject var viewModel: NewsViewModel
    var request: () -> Void
    var list: [Article]
    var state: NewsViewModel.State
    
    var body: some View {
        
        switch state {
        case .idle:
            Color.clear.onAppear(perform:  request)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error, retryAction: request)
        case .loaded:
            ZStack{
                List {
                    ForEach(list, id: \.self) { article in
                        ArticleRow(article: article, viewModel: viewModel)
                    }
                }
                
            }
        }
    }
}

struct ArticleRow: View {
    @State var article: Article
    @ObservedObject var viewModel: NewsViewModel
    
    
    var body: some View {
        NavigationLink(destination: DetailsPageView(article: $article, viewModel: viewModel)) {
            NewsCardView(article: $article)
        }
    }
}

