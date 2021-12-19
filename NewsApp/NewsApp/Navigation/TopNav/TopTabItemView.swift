//
//  TopTabItemView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 19.12.2021.
//

import SwiftUI

public struct TopTabItemView: View {
    public let isSelected: Bool
    public let item: TopTabItem
    @ObservedObject var coronaViewRouter: CoronaViewRouter
    var index: Int
    
    public var body: some View {
        HStack {
            Image(systemName: item.icon)
                .imageScale(.large)
                .foregroundColor(isSelected ? item.color : .primary)
            
            if isSelected {
                Text(item.title)
                    .foregroundColor(item.color)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        }
        .padding()
        .background(
            Capsule()
                .fill(isSelected ? item.color.opacity(0.2) : Color.clear)
        )
    }
}
