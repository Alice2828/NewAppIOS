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
    @ObservedObject var viewRouter: ViewRouter
    var geometry: GeometryProxy
    var body: some View {
        
        HStack {
            TabBarIcon(width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", viewRouter: viewRouter, assignedPage: .home)
            
            TabBarIcon(width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "heart", viewRouter: viewRouter, assignedPage: .liked)
            
            RoundTabBarIcon(width: geometry.size.width/7, height: geometry.size.width/7, systemIconName: "plus.circle.fill", tabName: "add", viewRouter: viewRouter, assignedPage: .corona).offset(y: -geometry.size.height/8/2)
            
            TabBarIcon(width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "magnifyingglass", viewRouter: viewRouter, assignedPage: .search)
            
            TabBarIcon(width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", viewRouter: viewRouter, assignedPage: .profile)
            
        }
        .frame(width: geometry.size.width, height: geometry.size.height/9)
        .background(Color.white.shadow(radius: 2))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabBarIcon: View {
    
    let width, height: CGFloat
    let systemIconName: String
    @ObservedObject var viewRouter: ViewRouter
    let assignedPage: ViewRouter.Page
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .foregroundColor(.blue)
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Spacer()
        } .padding(.horizontal, -4)
            .onTapGesture {
                viewRouter.currentPage = assignedPage
            }
    }
}

struct RoundTabBarIcon:View{
    let width, height: CGFloat
    let systemIconName, tabName: String
    @ObservedObject var viewRouter: ViewRouter
    let assignedPage: ViewRouter.Page
    
    var body: some View{
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .shadow(radius: 4)
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width-6 , height: width-6)
                .foregroundColor(.blue)
        }.onTapGesture {
            viewRouter.currentPage = assignedPage
        }
    }
}
