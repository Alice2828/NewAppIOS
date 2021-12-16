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
                BarChart(title: "Statistics", legend: "Kek", barColor: .blue, data: coronaVM.coronaInfoBarActive)
//                BarChart(title: "Statistics", legend: "Kek", barColor: .black, data: coronaVM.coronaInfoBarActive)
//                BarChart(title: "Statistics", legend: "Kek", barColor: .red, data: coronaVM.coronaInfoBarDeath)
//                BarChart(title: "Statistics", legend: "Kek", barColor: .green, data: coronaVM.coronaInfoBarRecovered)
        }
    }
}
