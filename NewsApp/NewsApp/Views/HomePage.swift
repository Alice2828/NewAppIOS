//
//  HomePage.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI

struct NewsList: View {
    @ObservedObject var viewModel: NewsViewModel
    var body: some View {
        
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform:  viewModel.getNewsSearchable)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error, retryAction: viewModel.getNewsSearchable)
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
        NavigationLink(destination: DetailsView(article: $article, viewModel: viewModel)) {
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
struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("An Error Occured")
                .font(.title)
            Text(error.localizedDescription)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40).padding()
            Button(action: retryAction, label: { Text("Retry").bold() })
        }
    }
}

struct HomePage: View {
    @ObservedObject var viewModel = NewsViewModel()
    
    var body: some View {
        NewsList(viewModel: viewModel)
    }
    
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
