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
    @Binding var article: Article
    
    
    var destination: some View {
        DetailsPageView(article: article, imageLoader: imageLoader)
            .navigationBarHidden(true)
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
                                        .clipped()
                                }
                                else{
                                    ImagePlaceholder()
                                }
                            }
                            else{
                                ImagePlaceholder()
                            }
                        }.overlay(
                            VStack(alignment: .leading){
                                Spacer()
                                if let author = article.author{
                                    CapsuleText(text: author)
                                }
                                
                                else {EmptyView()}
                            }
                                .padding(.bottom, 10)
                                .padding(.leading, 5)
                                .padding(.trailing, 5)
                        )
                            .padding(.bottom, 5)
                            .clipShape(RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous))
                        
                        //text part
                        CardTextDescription(article: article)
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
        
    }
}

struct CardTextDescription: View{
    var article: Article
    
    
    func getDate(isoDate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year], from: date)
        let finalDate = calendar.date(from:components)
        dateFormatter.dateFormat = "dd.MMM, yyyy"
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: finalDate!)
    }
    
    var body: some View{
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
                Text(getDate(isoDate: publishedAt))
                    .font(.custom("Avenir", size: 12))
                    .foregroundColor(SwiftUI.Color.gray)
            }
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

struct CapsuleText: View{
    var text: String
    
    var body: some View {
        Text(text)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .fixedSize(horizontal: false, vertical: true)
            .background(Color(UIColor.init(rgb:  0x81d5fa)))
            .clipShape(Capsule())
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
    }
}
