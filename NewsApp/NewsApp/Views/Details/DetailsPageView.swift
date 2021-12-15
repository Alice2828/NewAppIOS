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
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            ArticleDetail(article: $article, imageLoader: imageLoader).padding()
            Spacer()
        }
        .navigationTitle(article.title ?? "News Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ArticleDetail: View{
    @Binding var article: Article
    @ObservedObject var imageLoader: ImageLoader
    @EnvironmentObject var likesViewModel: LikesViewModel
    
    var imageToDisplay: Image {
        if likesViewModel.likesObservable.first(where: {$0.title == article.title}) != nil {
            print("HIHIHI \(likesViewModel.likesObservable)")
            return Image(systemName: "heart.fill")
        } else {
            return Image(systemName: "heart")
        }
    }
    var likeBtn: some View {
        LikeButton(action: likesViewModel.saveOrDeleteLike, article: article, imageToDisplay: imageToDisplay)
    }
    var shareBtn: some View {
        ShareButton(action: likesViewModel.shareArticle, article: article)
    }
    
    var body: some View {
            VStack {
                ZStack{
                    if let data = self.imageLoader.downloadedData{
                        if let uiImage = UIImage(data: data){
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        }
                        else{
                            ImagePlaceholder()
                        }
                    }
                    else{
                        ImagePlaceholder()
                    }
                    
                }.overlay(
                    VStack{
                        HStack {
                            Spacer()
                            HStack(alignment: .center, spacing: 10){
                                shareBtn
                                likeBtn
                            }
                            .background(Color(UIColor.init(rgb:  0x81d5fa)))
                            .clipShape(Capsule())
                        }
                        .padding(.top, 5)
                        .padding(.trailing, 5)
                        Spacer()
                    }
                )
                    .padding(.bottom, 5)
                    .clipShape(RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous))
                
                //content
                
                VStack(alignment: .leading, spacing: 10, content: {
                    if let title = article.title{
                        Text(title).multilineTextAlignment(.leading).font(.system(size: 20,  weight: .heavy))
                    }
                    if let publishedAt = article.publishedAt{
                        CapsuleText(text: publishedAt)
                    }
                    WebView(type: .public, url: article.url)
                })
            }
    }
}
