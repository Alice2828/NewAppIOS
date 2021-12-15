//
//  DetailsView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI
import CoreData

typealias MethodToDismiss = ()->Void

struct DetailsPageView: View {
    @State var article: Article
    @ObservedObject var imageLoader: ImageLoader
    @State var initialOffset: CGFloat?
    @State var offset: CGFloat?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            TopView(imageLoader: imageLoader, offset: self.$offset,
                    initialOffset: self.$initialOffset, actionBack: goBack, article: article)
            
            ScrollView(.vertical, showsIndicators: false) {
                GeometryReader { geometry in
                    Color.clear.preference(key: OffsetKey.self, value: geometry.frame(in: .global).minY)
                        .frame(height: 0)
                }
                ArticleDetail(article: $article, imageLoader: imageLoader, initialOffset: $initialOffset, offset: $offset).padding()
                Spacer()
            }
        }
        .onPreferenceChange(OffsetKey.self) {
            if self.initialOffset == nil || self.initialOffset == 0 {
                self.initialOffset = $0
            }
            self.offset = $0
        }
    }
    
    private func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
    
    
    private func scrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        let scrollOffset = geometry.frame(in: .global).minY
        return scrollOffset
    }
}

struct OffsetKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

struct ArticleDetail: View{
    @Binding var article: Article
    @ObservedObject var imageLoader: ImageLoader
    @EnvironmentObject var likesViewModel: LikesViewModel
    @Binding var initialOffset: CGFloat?
    @Binding var offset: CGFloat?
    var color: Color = Color("navTitle1")
    @State private var webViewHeight: CGFloat = .zero
    @State var isLoaderVisible = true
    
    var imageToDisplay: Image {
        if likesViewModel.likesObservable.first(where: {$0.title == article.title}) != nil {
            print("HIHIHI \(likesViewModel.likesObservable)")
            return Image(systemName: "heart.fill")
        } else {
            return Image(systemName: "heart")
        }
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10, content: {
            if isLoaderVisible {
                LoaderView()
            }
            WebView(type: .public, url: article.url, dynamicHeight: $webViewHeight, isLoaderVisible: $isLoaderVisible)
                .frame(height: webViewHeight)
        })
    }
    
}
