//
//  ImageLoader.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 08.12.2021.
//

import Foundation

class ImageLoader: ObservableObject {
    
    @Published var downloadedData: Data?
    
    
    func downloadImage(url: String) {
        guard let imageUrl = URL(string: url) else{
            return
        }
        URLSession.shared.dataTask(with: imageUrl){data,_,error in
            guard let data = data, error == nil else{
                return
            }
            DispatchQueue.main.async {
                self.downloadedData = data
            }
        }.resume()
    }
}
