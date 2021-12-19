//
//  TopTabs.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 18.12.2021.
//

import Foundation
import SwiftUI

struct TopTabs: View {
    var geometry: GeometryProxy
    @ObservedObject var coronaViewRouter: CoronaViewRouter
    @Binding public var selectedIndex: Int
    public let items: [TopTabItem]
    
    public init(geometry: GeometryProxy, coronaViewRouter: CoronaViewRouter, selectedIndex: Binding<Int>, items: [TopTabItem]) {
        self.geometry = geometry
        self.coronaViewRouter = coronaViewRouter
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    func itemView(at index: Int) -> some View {
        Button(action: {
            withAnimation {
                self.selectedIndex = index
                if index==0{
                    coronaViewRouter.currentPage = .info
                }
                else{
                    coronaViewRouter.currentPage = .chart
                }
            }
        }) {
            TopTabItemView(isSelected: index == selectedIndex, item: items[index], coronaViewRouter: coronaViewRouter, index: index)
        }
    }
    
    public var body: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<items.count) { index in
                self.itemView(at: index)
            }
        }
        .animation(.default)
        .background(Color.white)
        .cornerRadius(40)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -2)
        .edgesIgnoringSafeArea(.bottom)
    }
}
