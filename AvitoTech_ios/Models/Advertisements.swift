//
//  Advertisements.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

struct Advertisements: Decodable {
    let advertisements: [Items]
}

struct Items: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: URL
    let created_date: String
}
