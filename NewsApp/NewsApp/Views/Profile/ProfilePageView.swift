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
    @EnvironmentObject var usersManager: UsersManager
    
    var body: some View {
        VStack{
            if let currentUsr = usersManager.currentUser{
                if let img = currentUsr.image{
                    ProfileHeader(image: UIImage(data: img) ?? UIImage(imageLiteralResourceName: "placeholder"))
                }
                else{
                    ProfileHeader(image: UIImage(imageLiteralResourceName: "placeholder"))
                }
            }
            Button("Exit"){logout()}.padding()
            Spacer()
        }
        .padding(.bottom, 30)
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
