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
            NavigationView {
                TopPageView(viewModel: viewModel).navigationTitle("Top News")
            }
            .tabItem {
                Image(systemName: "house.circle")
                Text("Top")
            }
            
            NavigationView {
                SearchPageView(viewModel: viewModel).navigationTitle("Search News")
            }
            
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
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
