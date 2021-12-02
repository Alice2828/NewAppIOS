//
//  BottomNavBar.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI


struct BottomNavBar: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                }
            Text("Friends Screen")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Friends")
                }
            Text("Nearby Screen")
                .tabItem {
                    Image(systemName: "mappin.circle.fill")
                    Text("Nearby")
                }
        }
    }
}
