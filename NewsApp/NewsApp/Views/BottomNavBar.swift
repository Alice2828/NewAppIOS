//
//  BottomNavBar.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI
import CoreData

struct BottomNavBar: View {
    @ObservedObject var viewModel: NewsViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        TabView {
            NavigationView {
                TopPageView(viewModel: viewModel, context: context).navigationTitle("Top News")
            }.navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Top")
                }
            
            NavigationView {
                SearchPageView(viewModel: viewModel, context: context).navigationTitle("Search News")
            }.navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            NavigationView {
                LikesPageView(viewModel: viewModel, context: context).navigationTitle("My favorites")
            }.navigationViewStyle(StackNavigationViewStyle())
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
