//
//  ProfileHeader.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 16.12.2021.
//

import SwiftUI
import FirebaseAuth

struct ProfileHeader: View {
    let gradient = Gradient(colors: [.blue, .purple])
    
    @EnvironmentObject var usersManager: UsersManager
    @State private var isShowPhotoLibrary = false
    @State private var image: UIImage
    
    init(image: UIImage){
        self.image = image
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                VStack {
                    Image(uiImage: self.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .clipped()
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .padding(.top, 44)
                        .onTapGesture {
                            self.isShowPhotoLibrary = true
                        }
                    
                    Text(usersManager.currentUser?.name ?? "Your name").font(.system(size: 20)).bold().foregroundColor(.white)
                        .padding(.top, 12)
                    if let email = Auth.auth().currentUser?.email{
                        Text(email).font(.system(size: 18)).foregroundColor(.white)
                            .padding(.top, 4)
                    }
                }
                Spacer()
            }
        }
        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}
