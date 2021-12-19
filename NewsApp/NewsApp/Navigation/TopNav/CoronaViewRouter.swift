//
//  CoronaViewRouter.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 18.12.2021.
//

import Foundation
import SwiftUI


class CoronaViewRouter: ObservableObject {
    @Published var currentPage: Page = .info
    enum Page {
         case info
         case chart
     }
}

