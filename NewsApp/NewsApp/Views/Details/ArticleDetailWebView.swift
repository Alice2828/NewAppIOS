//
//  ArticleDetailWebView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 19.12.2021.
//

import SwiftUI

struct ArticleDetail: View{
    @Binding var article: Article
    @Binding var initialOffset: CGFloat?
    @Binding var offset: CGFloat?
    @State private var webViewHeight: CGFloat = .zero
    @State var isLoaderVisible = true
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10, content: {
            if isLoaderVisible {
                VStack{
                    Spacer()
                    LoaderView()
                    Spacer()
                }
            }
            WebView(type: .public, url: article.url, dynamicHeight: $webViewHeight, isLoaderVisible: $isLoaderVisible)
                .frame(height: webViewHeight)
        })
    }
    
}
