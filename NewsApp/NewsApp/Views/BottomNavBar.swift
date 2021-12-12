//
//  BottomNavBar.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI
import CoreData

struct BottomNavBar: View {
    @Binding var loggedIn: Bool
    var body: some View {
        TabView {
            NavigationView {
                TopPageView().navigationTitle("Top News")
            }.navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Top")
                }
            
            NavigationView {
                SearchPageView().navigationTitle("Search News")
            }.navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            NavigationView {
                LikesPageView().navigationTitle("My favorites")
            }.navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Likes")
                }
            ProfilePageView(loggedIn: $loggedIn)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}
