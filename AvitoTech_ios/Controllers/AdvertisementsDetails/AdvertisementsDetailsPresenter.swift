//
//  AdvertisementsDetailsPresenter.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

protocol AdvertisementsDetailsPresenterProtocol: AnyObject {
    var viewState: Observable<ViewState> { get }
    func fetchDetailInfo()
}

final class AdvertisementsDetailsPresenter: AdvertisementsDetailsPresenterProtocol {
    private let service: ListOfAdvertisementsServiceProtocol
    private(set) var detail: AdvertisementsDetails?
    private var detailId: String = ""
    
    var viewState: Observable<ViewState> = Observable(Optional.none)
    
    init(service: ListOfAdvertisementsServiceProtocol, detailId: String) {
        self.service = service
        self.detailId = detailId
    }
    
    func fetchDetailInfo() {
        viewState.value = .loading
        service.fetchDetailAdvertisement(id: detailId) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let data):
                self.viewState.value = .loaded
                self.detail = data
            case.failure(let error):
                self.viewState.value = .error(message: "fetchDetailInfo \(error.localizedDescription)")
            }
        }
    }
}
