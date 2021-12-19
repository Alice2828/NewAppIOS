//
//  InfoCardView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 19.12.2021.
//

import SwiftUI

struct InfoCardView:View{
    var geometry: GeometryProxy
    var imageName: String
    var textTitle: String
    var number: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous)
                .fill(.white)
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height/6)
            
            VStack(alignment: .leading){
                //icon and title
                HStackImgText(imageName: imageName, textTitle: textTitle)
                
                //number of people
                NumberOfPeopl(number: number)
                
            }.padding(.horizontal, 10)
        }
        .compositingGroup()
        .shadow(radius: 5)
    }
}

struct NumberOfPeopl: View{
    var number: String
    
    var body: some View{
        VStack(alignment: .leading, spacing: 2){
            //number
            Text(number).foregroundColor(.blue).fontWeight(.bold)
            
            //people and chart
            HStack{
                Text("People").font(.caption2)
                Spacer()
                Image("mainline").resizable()
                    .frame(width: 67.0, height: 28.0).padding(.trailing, 5)
            }
        }
    }
}
