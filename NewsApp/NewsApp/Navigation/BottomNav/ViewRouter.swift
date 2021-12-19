//
//  ViewRouter.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 14.12.2021.
//

import Foundation

import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .home
    enum Page {
         case home
         case search
         case liked
         case profile
        case corona
     }
}
