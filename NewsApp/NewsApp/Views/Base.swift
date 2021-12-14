//
//  HomePage.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 30.11.2021.
//

import SwiftUI
import CoreData

struct Base: View {
    @EnvironmentObject var newsViewModel: NewsViewModel
    @EnvironmentObject var likesViewModel: LikesViewModel
    @Environment(\.managedObjectContext) private var context
    
    @Binding var loggedIn: Bool
    var body: some View {
        BottomNavBar(loggedIn: $loggedIn).onAppear{
            self.likesViewModel.context = context
        }
    }
}

struct Base_Previews: PreviewProvider {
    static var previews: some View {
        Base(loggedIn: .constant(true))
    }
}
