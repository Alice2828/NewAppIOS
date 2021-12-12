//
//  NewsListView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 07.12.2021.
//

import SwiftUI
import CoreData

enum TypeList{
    case top
    case search
    case likes
}

struct NewsList: View {
    @EnvironmentObject var viewModel: NewsViewModel
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
                            
                            LikedArticleRow(article: article)
                        }
                    }
                    
                }
            }
        case .search:
            VStack{
                SearchBar(text: $viewModel.searchedText)
                    .padding()
                Spacer()
                switch viewModel.searchState {
                case .idle:
                    Color.clear.onAppear(perform:  viewModel.getNewsSearchableDefault)
                case .loading:
                    
                    ProgressView()
                case .failed(let error):
                    if (viewModel.searchedText == ""){
                        EmptyView()
                    }
                    else
                    {
                        ErrorView(error: error, retryAction: viewModel.getNewsSearchableDefault)
                        
                    }
                case .loaded:
                    VStack{
                        
                        ZStack{
                            List {
                                ForEach(viewModel.searchedNews, id: \.self) { article in
                                    LikedArticleRow(article: article)
                                }
                            }
                        }
                    }
                }
            }
        case .likes:
            
            ZStack{
                List {
                    ForEach(viewModel.likesIds, id: \.self) { articleId in
                        if let article = viewModel.topNews.first(where:{$0.id == articleId}){
                            LikedArticleRow(article: article)
                        }
                        else
                            if let article = viewModel.searchedNews.first(where:{$0.id == articleId}){
                                LikedArticleRow(article: article)
                            }
                    }
                    
                }
            }
        }
        
    }
}

struct LikedArticleRow: View {
    @State var article: Article
    
    var body: some View {
        LikedNewsCardView(article: $article)
            .onAppear(perform: {print("ID LALA LA \(article.id)")})
    }
}

