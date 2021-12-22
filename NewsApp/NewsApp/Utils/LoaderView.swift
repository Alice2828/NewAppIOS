//
//  LoaderView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

struct LoaderView: View {
    @State private var rotateDegree : CGFloat = 0
    
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.init(rgb:  0x81d5fa)), Color.purple]), startPoint: .top, endPoint: .bottom))
                .frame(width: 60, height: 60, alignment: .center)
            
            VStack {
                Circle()
                    .trim(from: 0.3, to: 1)
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width:50, height: 50)
                    .padding(.all, 8)
                    .rotationEffect(Angle(degrees: Double(rotateDegree)))
                    .onAppear {
                        DispatchQueue.main.async {
                            withAnimation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                                self.rotateDegree = 360
                            }
                        }
                    }
            }
        }
    }
}
