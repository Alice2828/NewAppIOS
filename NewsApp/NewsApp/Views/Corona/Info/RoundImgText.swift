//
//  RoundImgText.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 19.12.2021.
//

import SwiftUI

struct RoundImgAndText: View{
    var imageName: String
    var textTitle: String
    
    var body: some View {
        VStack(alignment: .center){
            Image(imageName).resizable()
                .frame(width: 80.0, height: 80.0)
                .shadow(radius: 5)
            Text(textTitle).font(.title3).fontWeight(.semibold).foregroundColor(.blue).multilineTextAlignment(.center)
        }
    }
}
