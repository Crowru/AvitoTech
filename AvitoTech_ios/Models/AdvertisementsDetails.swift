//
//  AdvertisementsDetails.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

struct AdvertisementsDetails: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: URL
    let created_date: String
    let description: String
    let email: String
    let phone_number: String
    let address: String
}
