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
    
    var body: some View {
        ZStack{
            List {
                ForEach(likesViewModel.likesObservable, id: \.self) { article in
                    LikedArticleRow(article: article)
                }
                
            }
        }.onAppear{likesViewModel.fetch()}
    }
}
