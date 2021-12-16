//
//  CoronaPageView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

struct CoronaPageView: View {
    @EnvironmentObject var coronaVM: CoronaVM
    
    var body: some View {
       
        switch coronaVM.state {

        case .idle:
            Color.clear.onAppear{
                coronaVM.getKz()
            }

        case .loading:
            ProgressView()

        case .failed(let error):
            ErrorView(error: error, retryAction: {
                coronaVM.getKz()
            })

        case .loaded:
            GeometryReader { geometry in
                HStack{
                BarChart(title: "Statistics", legend: "Kek", barColor: .blue, data: coronaVM.coronaInfoBar1, geometry: geometry)
                }
                BarChart(title: "Statistics", legend: "Kek", barColor: .black, data: coronaVM.coronaInfoBar2, geometry: geometry)
                BarChart(title: "Statistics", legend: "Kek", barColor: .red, data: coronaVM.coronaInfoBar3, geometry: geometry)
                BarChart(title: "Statistics", legend: "Kek", barColor: .green, data: coronaVM.coronaInfoBar4, geometry: geometry)
            }

        }
    }
}
