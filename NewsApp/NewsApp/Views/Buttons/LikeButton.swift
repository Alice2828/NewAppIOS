//
//  LikeButton.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

struct LikeButton: View {
    let action: (_ article: Article) -> ()
    var article: Article
    let imageToDisplay: Image
    var body: some View {
        Button(action:
                {
            action(article)
        })
        {
            imageToDisplay.renderingMode(.original)
        }
        .padding(.trailing, 20)
        .padding(.top, 5)
        .padding(.bottom, 5)
    }
}
