//
//  BottomNavBar.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI


struct BottomNavBar: View {
    @ObservedObject var viewModel: NewsViewModel
    var body: some View {
        TabView {
            TopPageView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "home.fill")
                    Text("Top")
                }
            SearchPageView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "search.fill")
                    Text("Friends")
                }
            Text("Nearby Screen")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Likes")
                }
            Text("Profile Screen")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}
