//
//  LikesCardView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 14.12.2021.
//

import Foundation
import SwiftUI

struct LikedNewsCardView: View {
    @ObservedObject var imageLoader = ImageLoader()
    @EnvironmentObject var likesViewModel: LikesViewModel
    @Binding var article: LikedArticle
    
    var imageToDisplay: Image {
        if likesViewModel.likesObservable.first(where: {$0.title == article.title}) != nil {
            return Image(systemName: "heart.fill")
        } else {
            return Image(systemName: "heart")
        }
    }
    
    var articleLiked: Article{
        Article(author: article.author, title: article.title, description: article.descrip, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content)
    }
    
    var destination: some View {
        DetailsPageView(article: articleLiked, imageLoader: imageLoader)
    }
    
    var likeBtn: some View {
        LikeButton(action: likesViewModel.saveOrDeleteLike, article: Article(author: article.author, title: article.title, description: article.descrip, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content), imageToDisplay: imageToDisplay)
    }
    
    
    var body: some View {
        
        ZStack{
            NavigationLink(destination: destination) {EmptyView()}
            HStack{
                //card itself
                ZStack {
                    RoundBackground()
                    //image
                    VStack(alignment: .leading, spacing: 10) {
                        ZStack{
                            if let data = self.imageLoader.downloadedData{
                                if let uiImage = UIImage(data: data){
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity, maxHeight: Consts.imageHeight)
                                }
                                else{
                                    ImagePlaceholder()
                                }
                            }
                            else{
                                ImagePlaceholder()
                            }
                        }.padding(.bottom, 5)
                        
                        CardTextDescription(article: articleLiked)
                            .padding(.horizontal,12)
                            .padding(.bottom,11)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: Consts.cardHeight)
                    .cornerRadius(Consts.cornerRadius)
                    
                }.onAppear(perform: {
                    if let urlToImage = article.urlToImage{
                        imageLoader.downloadImage(url: urlToImage)
                    }
                })
            }
            .compositingGroup()
            .shadow(radius: 10)
        }
        .overlay(Group{
            ZStack{
                Button(action:{
                    //likesViewModel.saveOrDeleteLike(article: articleLiked)
                }){
                    
                    imageToDisplay.renderingMode(.template)
                        .foregroundColor(.white)
                }.padding(.trailing, 20)
                    .padding(.top, 20)
                    .frame(width: 10, height: 10)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        })
        
    }
}


struct ImagePlaceholder: View {
    
    var body: some View {
        let imageHeight: CGFloat = 116
        Image("placeholder")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: imageHeight)
            .clipped()
    }
}

