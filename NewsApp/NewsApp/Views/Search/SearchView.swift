//
//  SearchView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 10.12.2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    @EnvironmentObject var viewModel: NewsViewModel
    
    var body: some View {
        HStack {
            
            TextField("Search ...", text: $text, onEditingChanged: {_ in
                viewModel.getNewsSearchable()
            }, onCommit: {viewModel.getNewsSearchable()})
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                withAnimation {
                                    UIApplication.shared.dismissKeyboard()
                                }
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    withAnimation {
                        UIApplication.shared.dismissKeyboard()
                    }
                    
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
