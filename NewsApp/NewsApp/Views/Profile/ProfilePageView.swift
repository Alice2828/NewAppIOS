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
    @State var alertIsPresented: Bool = false
    @State var text: String!
    
    func setTextValue(){
        text =  usersManager.currentUser?.name
    }
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                if let currentUsr = usersManager.currentUser{
                    if let img = currentUsr.image{
                        ProfileHeader(image: UIImage(data: img) ?? UIImage(imageLiteralResourceName: "placeholder"), name: $text, alertIsPresented: $alertIsPresented, logout: logout)
                    }
                    else{
                        ProfileHeader(image: UIImage(imageLiteralResourceName: "placeholder"), name: $text, alertIsPresented: $alertIsPresented, logout: logout)
                    }
                }
            }
            
            }.onAppear{setTextValue()}
            .textFieldAlert(isPresented: $alertIsPresented) { () -> TextFieldAlert in
                TextFieldAlert(title: "Change name", message: "Who are you?", text: self.$text){
                    usersManager.changeName(name: text)
                }
        }
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
