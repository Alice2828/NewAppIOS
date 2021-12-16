//
//  BarChartExt.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

struct BarChartCell: View {
    
    var value: Double
    var barColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(barColor)
            .scaleEffect(CGSize(width: 1, height: value), anchor: .bottom)
        
    }
}

struct BarChart: View {
    
    var title: String
    var legend: String
    var barColor: Color
    var data: [ChartData]
    var geometry: GeometryProxy
//
//    @State private var currentValue = ""
//    @State private var currentLabel = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.largeTitle)
           
                VStack {
                    HStack {
                        ForEach(0..<data.count, id: \.self) { i in
                            BarChartCell(value: normalizedValue(index: i), barColor: barColor)
                                .animation(.spring())
                                .padding(.top)
                        }
//                    if currentLabel.isEmpty {
//                        Text(legend)
//                            .bold()
//                            .foregroundColor(.black)
//                            .padding(5)
//                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
//                    } else {
//                        Text(currentLabel)
//                            .bold()
//                            .foregroundColor(.black)
//                            .padding(5)
//                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
//                            .animation(.easeIn)
//                    }
               }
            }
        }
        .padding()
    }
    
    func normalizedValue(index: Int) -> Double {
             var allValues: [Double]    {
                 var values = [Double]()
                 for data in data {
                     values.append(data.value)
                 }
                 return values
             }
             guard let max = allValues.max() else {
                 return 1
             }
             if max != 0 {
                 return Double(data[index].value)/Double(max)
             } else {
                 return 1
             }
    }
}

struct ChartData {
    var label: String
    var value: Double
}

