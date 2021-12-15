//
//  LoaderView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

struct LoaderView: View {
    @State var isSpinCircle = false
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color("navTitle1"), Color.purple]), startPoint: .top, endPoint: .bottom))
                .frame(width: 60, height: 60, alignment: .center)
            
            VStack {
                Circle()
                    .trim(from: 0.3, to: 1)
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width:50, height: 50)
                    .padding(.all, 8)
                    .rotationEffect(.degrees(isSpinCircle ? 0 : -360), anchor: .center)
                    .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false))
                    .onAppear {
                        self.isSpinCircle = true
                    }
            }
        }
    }
}
