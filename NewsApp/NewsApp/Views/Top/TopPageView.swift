//
//  TopPageView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 07.12.2021.
//

import SwiftUI
import CoreData

struct TopPageView: View {
    @ObservedObject var viewModel: NewsViewModel
    var context: NSManagedObjectContext
    var body: some View {
        NewsList(viewModel: viewModel, type: .top, context: context)
    }
}

//struct TopPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopPageView()
//    }
//}
