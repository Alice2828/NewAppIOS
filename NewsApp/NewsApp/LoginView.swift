//
//  LoginView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation
import SwiftUI

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
    var body: some View {
        Button("LOGIN"){}
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 220, height: 60)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(Color(UIColor.init(rgb:  0x81d5fa)))
            .cornerRadius(15.0)
        
    }
}

struct BtnForgotPassword: View {
    var body: some View {
        Text("Forgot password?")
            .font(.headline)
            .foregroundColor(.blue)
            .padding()
    }
}

struct Footer: View {
    var body: some View {
        HStack(alignment: .center)
        {
            Text("No account yet?")
                .font(.headline)
                .padding()
                .foregroundColor(.gray)
            
            Text("REGISTER")
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
            
        }
    }
}

struct CardView: View{
    @Binding var email: String
    @Binding var password: String
    
    var body: some View{
        GeometryReader { geometry in
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.init(rgb:  0xf9f9f9)))
                
                VStack {
                    WelcomeText()
                    Email(email: $email)
                    Password(password: $password)
                    HStack{
                        Spacer()
                        BtnForgotPassword()
                    }
                    BtnLogin()
                    Footer()
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
    
    var body: some View{
        GeometryReader { geometry in
            ZStack(alignment: .top){
                Color.clear
                Rectangle()
                    .fill(Color(UIColor.init(rgb:  0x81d5fa)))
                    .frame(width: geometry.size.width, height: geometry.size.height/2, alignment: .top)
                
                CardView(email: $email, password: $password)
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height*0.2, alignment: .center)
                    .padding()
                    .padding(.top, 100)
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

