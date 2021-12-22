//
//  LikesListView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 14.12.2021.
//

import Foundation
import SwiftUI

struct LikesListView: View {
    @EnvironmentObject var likesViewModel: LikesViewModel
    @State var showSecondView = false
    
    var body: some View {
        Group {
            if !showSecondView {
                VStack{
                    Spacer()
                    LoaderView()
                    Spacer()
                }
            }
            if showSecondView {
                ZStack{
                    List {
                        ForEach(likesViewModel.likesObservable, id: \.self) { article in
                            LikedArticleRow(article: article)
                        }
                        
                    }
                }.onAppear{likesViewModel.fetch()}
            }
        }.onAppear() {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                withAnimation {
                    self.showSecondView = true
                }
            }
        }
    }
}
