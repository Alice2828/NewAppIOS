//
//  TopListView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 14.12.2021.
//

import Foundation
import SwiftUI

struct TopListView: View {
    @EnvironmentObject var newsViewModel: NewsViewModel
    
    var body: some View {
        
        Group {
            switch newsViewModel.topState {
                
            case .idle:
                Color.clear.onAppear{
                    newsViewModel.getTop()
                }
                
            case .loading:
                VStack{
                    Spacer()
                    LoaderView()
                    Spacer()
                }
                
            case .failed(let error):
                ErrorView(error: error, retryAction: {
                    newsViewModel.getTop()
                })
                
            case .loaded:
                ZStack{
                    List {
                        ForEach(newsViewModel.topNews, id: \.self) { article in
                            NewsArticleRow(article: article)
                        }
                    }
                }
            }
        }
    }
}
