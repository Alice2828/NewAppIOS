//
//  ChartPageView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 18.12.2021.
//

import SwiftUI

struct ChartPageView: View {
    @EnvironmentObject var coronaVM: CoronaVM
    var geometry: GeometryProxy
    
    var body: some View {
        switch coronaVM.state {
            
        case .idle:
            Color.clear.onAppear{
                coronaVM.getKz()
            }
            
        case .loading:
            VStack{
                Spacer()
                LoaderView()
                Spacer()
            }
            
        case .failed(let error):
            ErrorView(error: error, retryAction: {
                coronaVM.getKz()
            })
            
        case .loaded:
            ScrollView(.horizontal){
                HStack{
                    BarChart(title:  coronaVM.label1, data: coronaVM.coronaInfoBar1, geometry: geometry).frame(width: geometry.size.width, height: 23*geometry.size.height/28 ,alignment: .bottom)
                    BarChart(title: coronaVM.label2, data: coronaVM.coronaInfoBar2, geometry: geometry).frame(width: geometry.size.width, height: 23*geometry.size.height/28 ,alignment: .bottom)
                    BarChart(title: coronaVM.label3, data: coronaVM.coronaInfoBar3, geometry: geometry).frame(width: geometry.size.width, height: 23*geometry.size.height/28 ,alignment: .bottom)
                    BarChart(title: coronaVM.label4, data: coronaVM.coronaInfoBar4, geometry: geometry).frame(width: geometry.size.width, height: 23*geometry.size.height/28 ,alignment: .bottom)
                }
            }
        }
    }
}
