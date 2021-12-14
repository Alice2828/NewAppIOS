//
//  HomePage.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI
import CoreData

struct Base: View {
    @EnvironmentObject var newsViewModel: NewsViewModel
    @EnvironmentObject var likesViewModel: LikesViewModel
    @StateObject var viewRouter: ViewRouter
    @Binding var loggedIn: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                BasicView(viewRouter: viewRouter, loggedIn: $loggedIn)
                Spacer()
                BottomNavBar(loggedIn: $loggedIn, viewRouter: viewRouter, geometry: geometry)
            }.onAppear{
                self.likesViewModel.fetch()
            }
        }
    }
}

struct BasicView: View {
    @ObservedObject var viewRouter: ViewRouter
    @Binding var loggedIn: Bool
    @EnvironmentObject var newsViewModel: NewsViewModel
    @EnvironmentObject var likesViewModel: LikesViewModel
    
    var body: some View {
        VStack {
            Spacer()
            switch viewRouter.currentPage {
            case .home:
                NavigationView{
                    TopPageView().navigationTitle("Top News") }.navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            case .search:
                NavigationView{
                    SearchPageView().navigationTitle("Search News")
                }
                .navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(backgroundColor: .systemIndigo, tintColor: .white)
            case .liked:
                NavigationView{
                    LikesPageView().navigationTitle("Favorites")
                }
                .navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(backgroundColor: .systemPink, tintColor: .white)
            case .profile:
                NavigationView{
                    ProfilePageView(loggedIn: $loggedIn) .navigationTitle("My Profile")
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarColor(backgroundColor: .systemBlue, tintColor: .white)
            }
            Spacer()
        }
    }
}

struct Base_Previews: PreviewProvider {
    static var previews: some View {
        Base(viewRouter:ViewRouter(), loggedIn: .constant(true))
    }
}
