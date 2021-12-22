//
//  BarChartExt.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//
import Foundation
import SwiftUI
import UIKit

struct BarChartCell: View {
    var label: String
    var value: Double
    var barColor: Color
    var geometry: GeometryProxy
    var maxValue: Double
    var fullBarHeight: Double
    
    var body: some View {
        let barHeight = (Double(fullBarHeight) / maxValue) * value + 20
        VStack{
            ZStack{
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(barColor)
                        .frame(height: CGFloat(barHeight), alignment: .trailing)
                }
                VStack {
                    Spacer()
                    Text("\(value, specifier: "%.0F")")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                
            }
            Text(label).lineLimit(1).frame(maxWidth: .infinity)
        }
    }
}

struct BarChart: View {
    
    var title: String
    var data: [ChartData]
    var geometry: GeometryProxy
    
    var body: some View {
        let fullBarHeight = 24*geometry.size.height/28 * 0.75
        let maxValue = data.map { $0.value }.max()!
        
        VStack(alignment: .leading) {
            HStack {
                ForEach(data, id: \.self) { value in
                    switch value.id{
                    case 1:
                        BarChartCell(label:"Confirmed", value: value.value, barColor: .blue, geometry: geometry, maxValue: maxValue, fullBarHeight: fullBarHeight)
                    case 2:
                        BarChartCell(label:"Active",value: value.value, barColor: .black, geometry: geometry,maxValue: maxValue, fullBarHeight: fullBarHeight)
                    case 3:
                        BarChartCell(label:"Deaths",value: value.value, barColor: .red, geometry: geometry,maxValue: maxValue, fullBarHeight: fullBarHeight)
                    case 4:
                        BarChartCell(label:"Recovered",value: value.value, barColor: .green, geometry: geometry,maxValue: maxValue, fullBarHeight: fullBarHeight)
                    default:
                        BarChartCell(label:"Confirmed",value: value.value, barColor: .green, geometry: geometry, maxValue: maxValue, fullBarHeight: fullBarHeight)
                    }
                }
            } .padding(.horizontal, 10)
            HStack{
                Spacer()
                Text(title).foregroundColor(.blue)
                    .fontWeight(.bold)
                Spacer()
            }
        }.padding(.bottom, 60)
    }
    
    
}

struct ChartData: Hashable {
    var id: Int
    var label: String
    var value: Double
}

