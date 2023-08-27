//
//  Advertisement.swift
//  AvitoTech
//
//  Created by Руслан  on 27.08.2023.
//

import UIKit

struct Advertisement {
    var imageURL: String
    var title: String
    var price: String
    var location: String
    var createdDate: String
    
    init(imageURL: String, title: String, price: String, location: String, createdDate: String) {
        self.imageURL = imageURL
        self.title = title
        self.price = price
        self.location = location
        self.createdDate = createdDate
    }
}
