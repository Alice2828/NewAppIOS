//
//  NewsListView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 07.12.2021.
//

import SwiftUI
import CoreData

struct SearchListView: View {
    @EnvironmentObject var newsViewModel: NewsViewModel
    
    var body: some View {
        
        VStack{
            SearchBar(text: $newsViewModel.searchedText)
                .padding()
            Spacer()
            
            switch newsViewModel.searchState {
                
            case .idle:
                Color.clear.onAppear{
                    newsViewModel.searchedText = "bitcoin"
                    newsViewModel.getNewsSearchableDefault()
                }
                
            case .loading:
                ProgressView()
                
            case .failed(let error):
                if (newsViewModel.searchedText == ""){
                    EmptyView()
                }
                else
                {
                    ErrorView(error: error, retryAction: {
                        newsViewModel.searchedText = "bitcoin"
                        newsViewModel.getNewsSearchableDefault()
                    })
                }
                
            case .loaded:
                ZStack{
                    List {
                        ForEach(newsViewModel.searchedNews, id: \.self) { article in
                            NewsArticleRow(article: article)
                        }
                    }
                }
            }
        }
    }
}

