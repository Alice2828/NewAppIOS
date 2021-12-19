//
//  HStackImgText.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 19.12.2021.
//

import SwiftUI

struct HStackImgText: View{
    var imageName: String
    var textTitle: String
    
    var body: some View {
        HStack{
            Image(imageName).resizable()
                .frame(width: 32.0, height: 32.0).padding(.trailing, 5)
                .shadow(radius: 5)
            Text(textTitle).font(.caption)
        }
    }
}
