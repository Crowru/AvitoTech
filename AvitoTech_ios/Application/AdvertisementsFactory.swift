//
//  AdvertisementsFactory.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

struct AdvertisementsFactory {
    static func makeListOfProducts() -> ListOfAdvertisementsViewController {
        let presenter = ListOfAdvertisementsPresenter()
        let viewController = ListOfAdvertisementsViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
