//
//  HomePage.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI

struct SearchPageView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        NewsList(viewModel: viewModel, request: viewModel.getNews)
    }
    
}

//struct HomePage_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePage()
//    }
//}
