//
//  File.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

final class AdvertisementsDetailsPresenter: AdvertisementsDetailsPresenterProtocol {
    
    weak var view: AdvertisementsDetailsViewControllerProtocol?
    
    //private let listOfProductsService = ListOfAdvertisementsService.shared
    
    private let service: ListOfAdvertisementsServiceProtocol
    private(set) var detail: AdvertisementsDetails?
    private var detailId: String = ""
    
    init(service: ListOfAdvertisementsServiceProtocol, detailId: String) {
        self.service = service
        self.detailId = detailId
    }
    
    func fetchDetailInfo() {
        service.fetchDetailAdvertisement(id: detailId) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let data):
                self.detail = data
            case.failure(let error):
                print("fetchDetailInfo \(error)")
            }
        }
    }
}
