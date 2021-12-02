//
//  DetailsView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI


typealias MethodToDismiss = ()->Void

struct DetailsView: View {
    @Binding var article: Article
//
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
//            ContactDetail(person: $person).padding()
//            CallButton(action: goBack).padding()
//            DeleteButton(person: $person, action: goBack, contactsViewModel: contactsViewModel).padding()
            Spacer()
        }
        .navigationTitle("Contact Info")
        .navigationBarTitleDisplayMode(.inline)
    }
    
//    private func goBack() {
//        presentationMode.wrappedValue.dismiss()
//    }
}

//struct ContactDetail: View{
//    @Binding var person: Person
//    
//    var body: some View {
//        HStack {
//            person.image
//                .resizable()
//                .frame(width: 80, height: 80)
//                .padding()
//            
//            VStack(alignment: .leading, spacing: 10, content: {
//                Text(person.name).multilineTextAlignment(.leading).font(.system(size: 20,  weight: .heavy))
//                Text(person.phone).multilineTextAlignment(.leading)
//            })
//            Spacer()
//        }
//    }
//}
//
//struct CallButton: View{
//    let action: MethodToDismiss
//    var body: some View {
//        Button("Call", action: action)
//            .font(.headline)
//            .foregroundColor(.white)
//            .frame(width: 220, height: 60)
//            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
//            .background(Color.green.opacity(0.7))
//            .cornerRadius(15.0)
//    }
//}
//
//struct DeleteButton: View{
//    @Binding var person: Person
//    let action: MethodToDismiss
//    @ObservedObject var contactsViewModel: ContactsViewModel
//    
//    var body: some View {
//        Button("Delete", action: {
//            let index = contactsViewModel.getIndexOf(person: person)
//            contactsViewModel.removeContact(index: index)
//            self.action()
//        })
//        .font(.headline)
//        .foregroundColor(.white)
//        .frame(width: 220, height: 60)
//        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
//        .background(Color.red.opacity(0.7))
//        .cornerRadius(15.0)
//    }
//}
