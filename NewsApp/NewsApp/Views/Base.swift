//
//  HomePage.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI

struct Base: View {
    @ObservedObject var viewModel = NewsViewModel()
    var body: some View {
        BottomNavBar(viewModel: viewModel)
    }
}

struct Base_Previews: PreviewProvider {
    static var previews: some View {
        Base()
    }
}
