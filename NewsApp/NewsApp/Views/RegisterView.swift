//
//  RegisterView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import Foundation
import SwiftUI

struct RegisterText: View {
    var body: some View {
        Text("Register")
            .font(.system(size: 20,  weight: .heavy))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.blue)
            .cornerRadius(16.0)
            .padding(.bottom, 20)
            .padding(.top, 20)
    }
}

struct EmailRegister: View {
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

struct NameRegister: View {
    @Binding var name: String
    
    var body: some View {
        HStack {
            Image(systemName: "person").padding(.leading, 5).foregroundColor(.gray)
            TextField("Name", text: $name)
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
        }
        .background(Color(UIColor.white))
        .cornerRadius(5.0)
        .padding(.bottom, 20)
    }
}

struct PasswordRegister: View {
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
struct BtnRegister: View {
    var body: some View {
        Button("Register"){}
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 220, height: 60)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(Color(UIColor.init(rgb:  0x81d5fa)))
            .cornerRadius(15.0)
        
    }
}


struct FooterRegister: View {
    var body: some View {
        HStack(alignment: .center)
        {
            Text("Have account?")
                .font(.headline)
                .padding()
                .foregroundColor(.gray)
            
            Text("LOGIN")
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
            
        }
    }
}

struct CardViewRegister: View{
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    
    var body: some View{
        GeometryReader { geometry in
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.init(rgb:  0xf9f9f9)))
                
                VStack {
                    RegisterText()
                    NameRegister(name: $name)
                    EmailRegister(email: $email)
                    PasswordRegister(password: $password)
                    BtnRegister()
                    FooterRegister()
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
            }.compositingGroup()
            .shadow(radius: 10)
            
        }
    }
}

struct RegisterView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    
    var body: some View{
        GeometryReader { geometry in
            ZStack(alignment: .top){
                Color.clear
                Rectangle()
                    .fill(Color(UIColor.init(rgb:  0x81d5fa)))
                    .frame(width: geometry.size.width, height: geometry.size.height/2, alignment: .top)
                
                CardViewRegister(email: $email, password: $password, name: $name)
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height*0.2, alignment: .center)
                    .padding()
                    .padding(.top, 100)
            }
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}


