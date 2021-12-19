//
//  ButtonImageInCircle.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 19.12.2021.
//

import SwiftUI

struct ButtonImageInCircle: View{
    var image: Image
    var body: some View {
        image
            .renderingMode(.original)
            .foregroundColor(Color("navTitle1"))
            .font(.system(size: 16, weight: .medium))
            .frame(width: 36, height: 36)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}
