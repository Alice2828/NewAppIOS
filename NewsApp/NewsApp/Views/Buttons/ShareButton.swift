//
//  ShareButton.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

struct ShareButton: View {
    let action: (_ article: Article) -> ()
    var article: Article
    var body: some View {
        Button(action:
                { action(article)
        }){
            Image(systemName: "square.and.arrow.up")
                .renderingMode(.original)
        }
        .padding(.leading, 20)
        .padding(.top, 5)
        .padding(.bottom, 5)
    }
}
