//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI
import Firebase
import FirebaseAuth
import CoreData
import Combine

@main
struct NewsAppApp: App {
    var coreDataStore = CoreDataStore.default
    var bag: [AnyCancellable] = []
    @StateObject var viewRouter = ViewRouter()
    @StateObject var newsViewModel = NewsViewModel()
    @StateObject var coronaVm = CoronaVM()
    @State var loggedIn: Bool = false
    @State var likesVm: LikesViewModel
    @State var usersManager: UsersManager
    
    init() {
        FirebaseApp.configure()
        let initVal = Auth.auth().currentUser != nil && (Auth.auth().currentUser?.isEmailVerified ?? false)
        _loggedIn = State(initialValue: initVal)
        _likesVm = State(initialValue: LikesViewModel(coreDataStore: coreDataStore))
        _usersManager = State(initialValue: UsersManager(coreDataStore: coreDataStore))
    }
    
    var body: some Scene {
        WindowGroup {
            if(loggedIn){
                Base(viewRouter: viewRouter, loggedIn: $loggedIn).environmentObject(newsViewModel)
                    .environmentObject(likesVm)
                    .environmentObject(coronaVm)
                    .environmentObject(usersManager)
            }
            else{
                LoginView(loggedIn: $loggedIn)
                    .environmentObject(UsersManager(coreDataStore: coreDataStore))
            }
        }
    }
}
