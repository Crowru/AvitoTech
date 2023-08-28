//
//  ListOfProductsServiceProtocol.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

protocol ListOfAdvertisementsServiceProtocol {
    var advertisements: [Advertisements]? { get }
    func fetchListAdvertisements(completion: @escaping (Result<[Items], Error>) -> Void)
    func fetchDetailAdvertisement(id: String, completion: @escaping (Result<AdvertisementsDetails, Error>) -> Void)
}
