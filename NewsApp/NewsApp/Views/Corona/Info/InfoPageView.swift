//
//  InfoPageView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 18.12.2021.
//

import SwiftUI

struct InfoPageView: View {
    @EnvironmentObject var coronaVM: CoronaVM
    var geometry: GeometryProxy
    
    var body: some View {
        switch coronaVM.infoState {
            
        case .idle:
            Color.clear.onAppear{
                coronaVM.getTotal()
            }
            
        case .loading:
            VStack{
                Spacer()
                LoaderView()
                Spacer()
            }
            
        case .failed(let error):
            ErrorView(error: error, retryAction: {
                coronaVM.getTotal()
            })
            
        case .loaded:
            InfoView(geometry: geometry)
        }
    }
}
