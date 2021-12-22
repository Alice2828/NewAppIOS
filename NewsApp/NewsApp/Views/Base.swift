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
    @EnvironmentObject var coronaVm: CoronaVM
    @EnvironmentObject var usersManager: UsersManager
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
    @EnvironmentObject var usersManager: UsersManager
    
    var body: some View {
        VStack {
            Spacer()
            switch viewRouter.currentPage {
            case .home:
                NavigationView{
                    TopPageView().navigationTitle("Top News") }.navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(backgroundColor: UIColor.init(rgb:  0x81d5fa), tintColor: .white)
            case .search:
                NavigationView{
                    SearchPageView().navigationTitle("Search News")
                }
                .navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(backgroundColor: UIColor.init(rgb:  0x81d5fa), tintColor: .white)
            case .liked:
                NavigationView{
                    LikesPageView().navigationTitle("Favorites")
                }
                .navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(backgroundColor: UIColor.init(rgb:  0x81d5fa), tintColor: .white)
            case .profile:
                ProfilePageView(loggedIn: $loggedIn)
            case .corona:
                CoronaPageView()
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
