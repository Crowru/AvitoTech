//
//  ListOfProductsViewControllerProtocol.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

protocol ListOfAdvertisementsViewControllerProtocol: AnyObject {
    var presenter: ListOfAdvertisementsPresenterProtocol? { get set }
    func reloadCollectionView()
}
