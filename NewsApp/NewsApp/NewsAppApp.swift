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
    @State var loggedIn: Bool = false
    @StateObject var viewRouter = ViewRouter()
    var coreDataStore = CoreDataStore.default
    var bag: [AnyCancellable] = []
    
    init() {
        FirebaseApp.configure()
        let initVal = Auth.auth().currentUser != nil && (Auth.auth().currentUser?.isEmailVerified ?? false)
        _loggedIn = State(initialValue: initVal)
    }
    
    var body: some Scene {
        WindowGroup {
            if(loggedIn){
                Base(viewRouter: viewRouter, loggedIn: $loggedIn).environmentObject(NewsViewModel())
                    .environmentObject(LikesViewModel(coreDataStore: coreDataStore))
                    .environmentObject(CoronaVM())
                    .environmentObject(UsersManager(coreDataStore: coreDataStore))
            }
            else{
                LoginView(loggedIn: $loggedIn)
                    .environmentObject(UsersManager(coreDataStore: coreDataStore))
            }
        }
    }
}
