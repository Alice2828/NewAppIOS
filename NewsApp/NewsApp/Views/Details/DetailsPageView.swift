//
//  DetailsView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI
import CoreData

typealias MethodToDismiss = ()->Void

struct DetailsPageView: View {
    @State var article: Article
    @ObservedObject var viewModel: NewsViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            ArticleDetail(article: $article, viewModel: viewModel).padding()
            //            CallButton(action: goBack).padding()
            //            DeleteButton(person: $person, action: goBack, contactsViewModel: contactsViewModel).padding()
            Spacer()
        }
        .navigationTitle(article.title ?? "News Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //    private func goBack() {
    //        presentationMode.wrappedValue.dismiss()
    //    }
}

struct ArticleDetail: View{
    @Binding var article: Article
    @ObservedObject var viewModel: NewsViewModel
    
    var imageToDisplay: Image {
        if viewModel.likes.first(where: {$0.articleId == (article.id )}) != nil {
            return Image(systemName: "heart.fill")
        } else {
            return Image(systemName: "heart")
        }
    }
    
    var body: some View {
        HStack {
            //            article.image
            //                .resizable()
            //                .frame(width: 80, height: 80)
            //                .padding()
            
            VStack(alignment: .leading, spacing: 10, content: {
                Text(article.description ?? "").multilineTextAlignment(.leading).font(.system(size: 20,  weight: .heavy))
                Text(article.url ?? "").multilineTextAlignment(.leading)
                Button(action:{
                    viewModel.saveOrDeleteLike(id: article.id )
                }){
                    
                    imageToDisplay.renderingMode(.original)
                }.padding(.trailing, 20)
                    .padding(.top, 20)
                    .frame(width: 10, height: 10)
            })
            Spacer()
        }
    }
}
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
