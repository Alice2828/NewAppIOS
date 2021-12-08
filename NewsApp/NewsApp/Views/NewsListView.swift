//
//  NewsListView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 07.12.2021.
//

import SwiftUI

enum TypeList{
    case top
    case search
}

struct NewsList: View {
    @ObservedObject var viewModel: NewsViewModel
    var type: TypeList
    
    var body: some View {
        switch type{
        case .top:
            switch viewModel.topState {
            case .idle:
                Color.clear.onAppear(perform:  viewModel.getTop)
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, retryAction: viewModel.getTop)
            case .loaded:
                ZStack{
                    List {
                        ForEach(viewModel.topNews, id: \.self) { article in
                            ArticleRow(article: article, viewModel: viewModel)
                        }
                    }
                    
                }
            }
        case .search:
            switch viewModel.searchState {
            case .idle:
                Color.clear.onAppear(perform:  viewModel.getNewsSearchable)
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, retryAction: viewModel.getNewsSearchable)
            case .loaded:
                ZStack{
                    List {
                        ForEach(viewModel.searchedNews, id: \.self) { article in
                            ArticleRow(article: article, viewModel: viewModel)
                        }
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

