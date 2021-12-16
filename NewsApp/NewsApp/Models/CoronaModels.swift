//
//  File.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import Foundation

struct General: Codable{
    
    var Global: Total
}

struct Total: Codable{
    
    var TotalConfirmed: Int?
    var NewConfirmed: Int?
    var TotalDeaths: Int?
    var TotalRecovered: Int?
}

struct DataCorona: Codable{
    var Confirmed: Int
    var Active: Int
    var Deaths: Int
    var Recovered: Int
    var Date: String
}
