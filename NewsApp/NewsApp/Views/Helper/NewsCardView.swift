//
//  NewsCardView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 08.12.2021.
//

import SwiftUI

struct NewsCardView: View {
    @ObservedObject var imageLoader = ImageLoader()
    @Binding var article: Article
    
    let cardAndImageWidth: CGFloat = 170
    let cardHeight: CGFloat = 174
    let imageHeight: CGFloat = 116
    let cornerRadius: CGFloat = 5
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
                .frame(width: cardAndImageWidth, height: cardHeight)
                .background(SwiftUI.Color.white)
            VStack(alignment: .leading, spacing: 10) {
                if let data = self.imageLoader.downloadedData{
                    if let uiImage = UIImage(data: data){
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: cardAndImageWidth, height: imageHeight)
                            .clipped()
                    }
                    else{
                        ImagePlaceholder()
                    }
                }
                else{
                    ImagePlaceholder()
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(article.title ?? "")
                        .font(.custom("Avenir", size: 14))
                        .fontWeight(.bold)
                    Text(article.description ?? "")
                        .font(.custom("Avenir", size: 12))
                        .foregroundColor(SwiftUI.Color.gray)
                }
                .padding(.horizontal,12)
                .padding(.bottom,11)
            }
            .frame(width: cardAndImageWidth, height: cardHeight)
            .cornerRadius(cornerRadius)
        }.onAppear(perform: {
            if let urlToImage = article.urlToImage{
                imageLoader.downloadImage(url: urlToImage)
            }
        })
    }
}


struct ImagePlaceholder: View {
    
    var body: some View {
        let cardAndImageWidth: CGFloat = 170
        let imageHeight: CGFloat = 116
        Image("placeholder")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: cardAndImageWidth, height: imageHeight)
            .clipped()
    }
}
