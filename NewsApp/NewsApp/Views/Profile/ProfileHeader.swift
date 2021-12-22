//
//  ProfileHeader.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 16.12.2021.
//

import SwiftUI
import FirebaseAuth

struct ProfileHeader: View {
    let gradient = Gradient(colors: [Color(UIColor.init(rgb:  0x81d5fa)), .purple])
    
    @EnvironmentObject var usersManager: UsersManager
    @State private var isShowPhotoLibrary = false
    @State private var showingAlertForImage = false
    @State private var image: UIImage
    
    @Binding var alertIsPresented: Bool
    @Binding var text: String? // this is updated as the user types in the text field
    var logout: () -> ()
    
    init(image: UIImage, name: Binding<String?>, alertIsPresented: Binding<Bool>, logout: @escaping () -> ()){
        self.image = image
        self._text = name
        self._alertIsPresented = alertIsPresented
        self.logout = logout
    }
    
    var body: some View {
        VStack() {
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
                            self.showingAlertForImage = true
                        }
                    
                    //card
                    ZStack{
                        RoundedRectangle(cornerRadius: Consts.cornerRadius, style: .continuous)
                            .fill(Color(UIColor.init(rgb:  0xf9f9f9)))
                            .frame(maxWidth: .infinity, maxHeight: 100).padding()
                        VStack{
                            HStack(alignment: .center){
                                Text(usersManager.currentUser?.name ?? "Your name").font(.system(size: 20)).bold().foregroundColor(.blue)
                                Button(action: {
                                    alertIsPresented = true
                                })
                                {
                                    Image(systemName: "pencil.circle.fill").resizable()
                                        .foregroundColor(.blue).frame(width: 24.0, height: 24.0).shadow(radius: 5)
                                }
                            } .padding(.top, 20)
                            
                            if let email = Auth.auth().currentUser?.email{
                                Text(email).font(.system(size: 18)).foregroundColor(.blue)
                                    .padding(.top, 4)
                                    .padding(.bottom, 20)
                            }
                        }
                    }.compositingGroup().shadow(radius: 5)
                    
                    Button("Exit"){logout()}
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 220, height: 60)
                    .frame(alignment: .center)
                    .background(Color(UIColor.init(rgb:  0x81d5fa)))
                    .cornerRadius(15.0)
                    .padding(5)
                    .padding(.top, 25)
                    .shadow(radius: 5)
                    Spacer()
                }
                Spacer()
            }
        }
        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        
        .alert(isPresented: $showingAlertForImage) {
            Alert(title: Text("Change your avatar"),
                  message: Text("Choose right option"),
                  primaryButton: .destructive(Text("Delete")) {
                usersManager.deleteImage()
            },
                  secondaryButton: .default(Text("Change image"), action: {isShowPhotoLibrary = true}))
        }
        
        
    }
}
