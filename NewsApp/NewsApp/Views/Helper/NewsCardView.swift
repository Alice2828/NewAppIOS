//
//  NewsCardView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 08.12.2021.
//

import SwiftUI
import CoreData

//struct NewsCardView: View {
//    @ObservedObject var imageLoader = ImageLoader()
//    @Binding var article: Article
//
//    let cardAndImageWidth: CGFloat = 170
//    let cardHeight: CGFloat = 174
//    let imageHeight: CGFloat = 116
//    let cornerRadius: CGFloat = 5
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: cornerRadius)
//                .strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
//                .frame(width: cardAndImageWidth, height: cardHeight)
//                .background(SwiftUI.Color.white)
//            VStack(alignment: .leading, spacing: 10) {
//                if let data = self.imageLoader.downloadedData{
//                    if let uiImage = UIImage(data: data){
//                        Image(uiImage: uiImage)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: cardAndImageWidth, height: imageHeight)
//                            .clipped()
//                    }
//                    else{
//                        ImagePlaceholder()
//                    }
//                }
//                else{
//                    ImagePlaceholder()
//                }
//                VStack(alignment: .leading, spacing: 2) {
//                    Text(article.title ?? "")
//                        .font(.custom("Avenir", size: 14))
//                        .fontWeight(.bold)
//                    Text(article.description ?? "")
//                        .font(.custom("Avenir", size: 12))
//                        .foregroundColor(SwiftUI.Color.gray)
//                }
//                .padding(.horizontal,12)
//                .padding(.bottom,11)
//            }
//            .frame(width: cardAndImageWidth, height: cardHeight)
//            .cornerRadius(cornerRadius)
//        }.onAppear(perform: {
//            if let urlToImage = article.urlToImage{
//                imageLoader.downloadImage(url: urlToImage)
//            }
//        })
//    }
//}

struct LikedNewsCardView: View {
    @ObservedObject var imageLoader = ImageLoader()
    @ObservedObject var viewModel: NewsViewModel
    @Binding var article: Article
    
    let cardAndImageWidth: CGFloat = 170
    let imageHeight: CGFloat = 150
    var imageToDisplay: Image {
        if viewModel.likes.first(where: {$0.articleId == (article.id )}) != nil {
            return Image(systemName: "heart.fill")
        } else {
            return Image(systemName: "heart")
        }
    }
    
    var body: some View {
        
        ZStack{
            NavigationLink(destination: DetailsPageView(article: article, viewModel: viewModel)) {EmptyView()}
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
                                        .frame(maxWidth: .infinity, maxHeight: imageHeight)
                                }
                                else{
                                    ImagePlaceholder()
                                }
                            }
                            else{
                                ImagePlaceholder()
                            }
                        }.padding(.bottom, 5)
                        
                        //text part
                        VStack(alignment: .leading, spacing: 5) {
                            if let title = article.title{
                                Text(title)
                                    .foregroundColor(.blue)
                                    .font(.custom("Avenir", size: 14))
                                    .fontWeight(.bold)
                            }
                            if let description = article.description{
                                Text(description)
                                    .font(.custom("Avenir", size: 12))
                            }
                            if let publishedAt = article.publishedAt{
                                Text(publishedAt)
                                    .font(.custom("Avenir", size: 12))
                                    .foregroundColor(SwiftUI.Color.gray)
                            }
                        }
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
            }.compositingGroup()
                .shadow(radius: 10)
        }
        .overlay(Group{
            ZStack{
                Button(action:{
                    viewModel.saveOrDeleteLike(id: article.id )
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


struct RoundBackground: View{
    var body: some View {
        RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous)
            .fill(Color(UIColor.init(rgb:  0xf9f9f9)))
            .frame(maxWidth: .infinity, maxHeight: Consts.cardHeight)
        
    }
}
