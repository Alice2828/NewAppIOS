//
//  CoronaPageView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

let items: [TopTabItem] = [
    TopTabItem(icon: "info.circle", title: "Info", color: .purple),
    TopTabItem(icon: "chart.bar", title: "Chart", color: Color(UIColor.init(rgb:  0x81d5fa)))
]

struct CoronaPageView: View {
    @EnvironmentObject var coronaVM: CoronaVM
    @StateObject var coronaViewRouter = CoronaViewRouter()
    @State private var selectedIndex: Int = 0
    
    var selectedItem: TopTabItem {
        items[selectedIndex]
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center){
                //tabs
                TopTabs(geometry: geometry, coronaViewRouter: coronaViewRouter, selectedIndex: $selectedIndex, items: items)
                //info or chart
                ZStack(alignment: .center){
                    switch coronaViewRouter.currentPage {
                    case .info:
                        InfoPageView(geometry: geometry)
                    case .chart:
                        ChartPageView(geometry: geometry)
                    }
                }
            }.frame(maxWidth: .infinity)
        }
    }
}
