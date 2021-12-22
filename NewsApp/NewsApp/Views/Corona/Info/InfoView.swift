//
//  InfoView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 19.12.2021.
//

import SwiftUI

struct InfoView: View{
    @EnvironmentObject var coronaVM: CoronaVM
    var geometry: GeometryProxy
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    InfoCardView(geometry: geometry, imageName: "confirm_icon", textTitle: "Confirmed Cases", number: coronaVM.confirmed)
                        .padding(.leading, 3)
                    InfoCardView(geometry: geometry, imageName: "recovered_icon", textTitle: "Total Recovered", number: coronaVM.recovered)
                        .padding(.trailing, 3)
                }.padding(.leading, 3)
                
                VStack{
                    InfoCardView(geometry: geometry, imageName: "death_icon", textTitle: "Total Death", number: coronaVM.death)
                        .padding(.leading, 3)
                    InfoCardView(geometry: geometry, imageName: "new_cases_icon", textTitle: "New Cases", number: coronaVM.newConf)
                        .padding(.trailing, 3)
                }.padding(.trailing, 3)
                
            }.padding(.horizontal,5)
            
            PeventionHStack()
            
        }.padding(.top, 20)
    }
}

struct PeventionHStack: View{
    var body: some View{
        HStack{
            Text("Prevention").font(.title2).foregroundColor(.blue).fontWeight(.bold).padding().padding(.top, 20)
            Spacer()
        }
        HStack(){
            RoundImgAndText(imageName: "clean", textTitle: "Clean Disinfects").padding(.horizontal, 15)
            RoundImgAndText(imageName: "hand_wash", textTitle: "Wash hands").padding(.horizontal, 15)
            RoundImgAndText(imageName: "use_mask", textTitle: "Use Masks").padding(.horizontal, 15)
        }.frame(maxWidth: .infinity)
    }
}
