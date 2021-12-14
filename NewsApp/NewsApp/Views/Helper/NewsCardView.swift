//
//  NewsCardView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 08.12.2021.
//

import SwiftUI
import CoreData


struct NewsCardView: View {
    @ObservedObject var imageLoader = ImageLoader()
    @EnvironmentObject var newsViewModel: NewsViewModel
    @Environment(\.managedObjectContext) private var context
    @Binding var article: Article
    
    let cardAndImageWidth: CGFloat = 170
    let imageHeight: CGFloat = 150
    
    var body: some View {
        
        ZStack{
            NavigationLink(destination: DetailsPageView(article: article, newsViewModel: newsViewModel)) {EmptyView()}
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
        
    }
}



struct RoundBackground: View{
    var body: some View {
        RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous)
            .fill(Color(UIColor.init(rgb:  0xf9f9f9)))
            .frame(maxWidth: .infinity, maxHeight: Consts.cardHeight)
        
    }
}
