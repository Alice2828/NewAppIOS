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
    
    var body: some View {
        
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform:  viewModel.getNews)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error, retryAction: viewModel.getNews)
        case .loaded(let news):
            ZStack{
                List {
                    ForEach(news, id: \.self) { article in
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
            HStack {
                //                article.image
                //                    .resizable()
                //                    .frame(width: 80, height: 80)
                //                    .padding()
                //
                VStack(alignment: .leading, spacing: 10, content: {
                    Text(article.title).multilineTextAlignment(.leading).font(.system(size: 20,  weight: .heavy))
                    Text(article.description).multilineTextAlignment(.leading)
                })
                Spacer()
            }
        }
    }
}
