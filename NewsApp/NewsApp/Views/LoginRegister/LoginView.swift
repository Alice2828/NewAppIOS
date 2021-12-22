//
//  LoginView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct WelcomeText: View {
    var body: some View {
        Text("LOGIN")
            .font(.system(size: 20,  weight: .heavy))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.blue)
            .cornerRadius(16.0)
            .padding(.bottom, 20)
            .padding(.top, 20)
    }
}

struct Email: View {
    @Binding var email: String
    
    var body: some View {
        HStack {
            Image(systemName: "mail").padding(.leading, 5).foregroundColor(.gray)
            TextField("Email", text: $email)
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
        }
        .background(Color(UIColor.white))
        .cornerRadius(5.0)
        .padding(.bottom, 20)
    }
}

struct Password: View {
    @Binding var password: String
    
    var body: some View {
        HStack {
            Image(systemName: "lock").padding(.leading, 5).foregroundColor(.gray)
            SecureField("Password", text: $password)
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
        }
        .background(Color(UIColor.white))
        .cornerRadius(5.0)
        .padding(.bottom, 20)
        
    }
}
struct BtnLogin: View {
    @Binding var loggedIn: Bool
    @Binding var email: String
    @Binding var password: String
    @State private var showingAlert = false
    
    @EnvironmentObject var usersManager: UsersManager
    
    var body: some View {
        Button("LOGIN"){login()}
        .font(.headline)
        .foregroundColor(.white)
        .frame(width: 220, height: 60)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .background(Color(UIColor.init(rgb:  0x81d5fa)))
        .cornerRadius(15.0)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error..."), message: Text("Register or check email"), dismissButton: .cancel())
        }
        
    }
    
    func login() {
        if (email != "" && password != ""){
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    if Auth.auth().currentUser!.isEmailVerified{
                        loggedIn = true
                        usersManager.fetch(username: email)
                        print("success")
                    }
                    else {
                        showingAlert = true
                        print(error?.localizedDescription ?? "")
                    }
                    
                } else {
                    showingAlert = true
                    print(error?.localizedDescription ?? "")
                }
            }
        }
        else{
            showingAlert = true
        }
    }
}

struct Footer: View {
    @Binding var goToRegister: Bool
    
    var body: some View {
        HStack(alignment: .center)
        {
            Text("No account yet?")
                .font(.headline)
                .padding()
                .foregroundColor(.gray)
            
            Button(action: {
                self.goToRegister = true
                
            }) {
                Text("REGISTER")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
    }
}

struct CardView: View{
    @Binding var email: String
    @Binding var password: String
    @Binding var goToRegister: Bool
    @Binding var loggedIn: Bool
    
    var body: some View{
        GeometryReader { geometry in
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.init(rgb:  0xf9f9f9)))
                
                VStack {
                    WelcomeText()
                    Email(email: $email)
                    Password(password: $password)
                    BtnLogin(loggedIn: $loggedIn, email: $email, password: $password)
                    Footer(goToRegister: $goToRegister)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            }.compositingGroup()
                .shadow(radius: 10)
            
        }
    }
}

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var goToRegister: Bool = false
    @Binding var loggedIn: Bool
    @EnvironmentObject var usersManager: UsersManager
    
    var body: some View{
        GeometryReader { geometry in
            ZStack(alignment: .top){
                Color.clear
                Rectangle()
                    .fill(Color(UIColor.init(rgb:  0x81d5fa)))
                    .frame(width: geometry.size.width, height: geometry.size.height/2, alignment: .top)
                
                CardView(email: $email, password: $password, goToRegister: $goToRegister, loggedIn: $loggedIn)
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height*0.2, alignment: .center)
                    .padding()
                    .padding(.top, 100)
            }
        }.navigate(to: RegisterView(loggedIn: $loggedIn, goToRegister: $goToRegister), when: $goToRegister)
    }
}
