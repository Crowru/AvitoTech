//
//  ListOfProductsPresenter.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

final class ListOfAdvertisementsPresenter: ListOfAdvertisementsPresenterProtocol {
    weak var view: ListOfAdvertisementsViewControllerProtocol?
    private let listOfProductsService = ListOfAdvertisementsService.shared
    
    var items: [Items]? {
        didSet {
            view?.reloadCollectionView()
        }
    }
    
    func getData() {
        listOfProductsService.fetchListAdvertisements { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.items = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
