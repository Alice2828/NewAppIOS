//
//  LikesPageView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 09.12.2021.
//

import SwiftUI
import CoreData

struct LikesPageView: View {
    @ObservedObject var viewModel: NewsViewModel
    var context: NSManagedObjectContext
    
    var body: some View {
        NewsList(viewModel: viewModel, type: .likes, context: context)
    }
}
//
//struct LikesPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikesPageView()
//    }
//}
