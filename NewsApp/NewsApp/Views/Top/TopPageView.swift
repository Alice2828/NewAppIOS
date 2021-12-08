//
//  TopPageView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 07.12.2021.
//

import SwiftUI

struct TopPageView: View {
    @ObservedObject var viewModel: NewsViewModel
    var body: some View {
        NewsList(viewModel: viewModel, request: viewModel.getTop, list: viewModel.topNews,
                 state: viewModel.topState)
    }
}

//struct TopPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopPageView()
//    }
//}
