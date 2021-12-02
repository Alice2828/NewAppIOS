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
        ZStack{
            
            List {
                ForEach(viewModel.news, id: \.self) { article in
                    ArticleRow(article: article, viewModel: viewModel)
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
