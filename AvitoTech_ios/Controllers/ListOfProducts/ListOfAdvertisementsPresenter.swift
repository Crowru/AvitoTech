//
//  ListOfProductsPresenter.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

protocol ListOfAdvertisementsPresenterProtocol: AnyObject {
    var items: Observable<[Items]> { get }
    var viewState: Observable<ViewState> { get }
    func getData()
}

final class ListOfAdvertisementsPresenter: ListOfAdvertisementsPresenterProtocol {
    private let listOfProductsService: ListOfAdvertisementsServiceProtocol
    var items: Observable<[Items]> = Observable([])
    var viewState: Observable<ViewState> = Observable(ViewState.none)
    
    init(listOfProductsService: ListOfAdvertisementsServiceProtocol) {
        self.listOfProductsService = listOfProductsService
    }
    
    func getData() {
        viewState.value = .loading
        listOfProductsService.fetchListAdvertisements { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.items.value = data
                self.viewState.value = .loaded
            case .failure(let error):
                self.viewState.value = .error(message: error.localizedDescription)
            }
        }
    }
}
