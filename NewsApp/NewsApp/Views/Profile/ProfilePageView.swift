//
//  ProfilePageView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 12.12.2021.
//

import SwiftUI
import FirebaseAuth
import CoreData

struct ProfilePageView: View {
    @Binding var loggedIn: Bool
    var body: some View {
        Button("Exit"){logout()}
    }
    
    func logout(){
        do{
            try Auth.auth().signOut()
            loggedIn = false
            
        }
        catch{
            print("Error sign out")
        }
    }
}
