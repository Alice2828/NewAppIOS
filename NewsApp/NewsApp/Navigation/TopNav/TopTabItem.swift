//
//  TopTabItem.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 19.12.2021.
//

import SwiftUI

public struct TopTabItem {
    public let icon: String
    public let title: String
    public let color: Color
    
    public init(icon: String,
                title: String,
                color: Color) {
        self.icon = icon
        self.title = title
        self.color = color
    }
}
