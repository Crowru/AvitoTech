//
//  AdvertisementsDetailsPresenterProtocol.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

protocol AdvertisementsDetailsPresenterProtocol: AnyObject {
    var view: AdvertisementsDetailsViewControllerProtocol? { get set }
    func fetchDetailInfo()
}
