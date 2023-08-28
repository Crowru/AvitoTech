//
//  ListOfAdvertisementsPresenterProtocol.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import Foundation

protocol ListOfAdvertisementsPresenterProtocol: AnyObject {
    var view: ListOfAdvertisementsViewControllerProtocol? { get set }
    var items: [Items]? { get }
    func getData()
}
