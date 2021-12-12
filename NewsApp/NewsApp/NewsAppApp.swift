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

@main
struct NewsAppApp: App {
    let persistenceController = PersistenceController.shared
    let context = PersistentCloudKitContainer.persistentContainer.viewContext
    @State var loggedIn: Bool = false
    // 1
    @FetchRequest(
        // 2
        entity: MyUser.entity(),
        // 3
        sortDescriptors: [
            NSSortDescriptor(keyPath: \MyUser.username, ascending: true)
        ]
        // 4
    ) var users: FetchedResults<MyUser>
    
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \MyUser.username, ascending: true)],
    //        animation: .default)
    //    private var users: FetchedResults<MyUser>
    
    init() {
        FirebaseApp.configure()
        let initVal = Auth.auth().currentUser != nil && (Auth.auth().currentUser?.isEmailVerified ?? false)
        _loggedIn = State(initialValue: initVal)
//        print("HIHI 2 \(Auth.auth().currentUser!)")
//        print("HIHI 3 \(Auth.auth().currentUser!.isEmailVerified)")
//        print("HIHI 4 \(loggedIn)")
//        let storeContainer = PersistentCloudKitContainer.persistentContainer.persistentStoreCoordinator
//
//        // Delete each existing persistent store
//        do {for store in storeContainer.persistentStores {
//            try storeContainer.destroyPersistentStore(
//                at: store.url!,
//                ofType: store.type,
//                options: nil
//            )
//        }
//        }
//        catch{}
//
//        // Re-create the persistent container
//        PersistentCloudKitContainer.persistentContainer = NSPersistentContainer(
//            name: "LikedArticle" // the name of
//            // a .xcdatamodeld file
//        )
//
//        // Calling loadPersistentStores will re-create the
//        // persistent stores
//        PersistentCloudKitContainer.persistentContainer.loadPersistentStores {
//            (store, error) in
//            // Handle errors
//        }
        
    }
    var body: some Scene {
        WindowGroup {
            if(loggedIn){
                Base(loggedIn: $loggedIn).environmentObject(NewsViewModel())
                    .environment(\.managedObjectContext, context)
            }
            else{
                LoginView(loggedIn: $loggedIn)
            }
        }
    }
}
