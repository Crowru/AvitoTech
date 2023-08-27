//
//  ViewController.swift
//  AvitoTech_ios
//
//  Created by Руслан  on 24.08.2023.
//

import UIKit

final class ListOfProductsViewController: UIViewController, UICollectionViewDataSource {
    
    private let params = GeometryParams(cellCount: 2, leftInset: 15, rightInset: 15, cellSpacing: 10)
    
    var advertisements: [Advertisement] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ListOfAdvertisementsCell.self, forCellWithReuseIdentifier: ListOfAdvertisementsCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadAdvertisements()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadAdvertisements() {
        advertisements = [
            Advertisement(imageURL: "https://www.avito.st/s/interns-ios/images/1.png", title: "Клавиатура kbdfans tofu65", price: "20 000 ₽", location: "Москва, Кунцевская", createdDate: "21 августа, 17:48"),
            Advertisement(imageURL: "https://www.avito.st/s/interns-ios/images/1.png", title: "Кондиционер бу", price: "7 000 ₽", location: "Москва, Народное Ополчение", createdDate: "21 августа, 08:48"),
            Advertisement(imageURL: "https://www.avito.st/s/interns-ios/images/1.png", title: "Новые клавиатура Nuphy", price: "10 990 ₽", location: "Москва, Выхино", createdDate: "Сегодня, 13:51"),
            Advertisement(imageURL: "https://www.avito.st/s/interns-ios/images/1.png", title: "Клавиатура dark project kd83a", price: "7 499 ₽", location: "Москва, Динамо", createdDate: "16 августа, 13:30"),
            Advertisement(imageURL: "https://www.avito.st/s/interns-ios/images/1.png", title: "Клавиатура ливафт tofu65", price: "3 000 ₽", location: "Москва, Аннино", createdDate: "16 августа, 13:30"),
            Advertisement(imageURL: "https://www.avito.st/s/interns-ios/images/1.png", title: "Клавиатура ливафт tofu65", price: "2 000 ₽", location: "Москва, Бутово", createdDate: "13 августа, 12:20"),
            Advertisement(imageURL: "https://www.avito.st/s/interns-ios/images/1.png", title: "Клавиатура ливафт tofu65", price: "1 000 ₽", location: "Москва, Кунцевская", createdDate: "11 августа, 10:30"),
        ]
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListOfAdvertisementsCell.identifier, for: indexPath) as? ListOfAdvertisementsCell else { return UICollectionViewCell() }
        cell.setupCell()
        
        let advertisement = advertisements[indexPath.item]
        cell.titleLabel.text = advertisement.title
        cell.price.text = advertisement.price
        cell.location.text = advertisement.location
        cell.createdDate.text = advertisement.createdDate
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ListOfProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - params.paddingWidth
        let cellWidth = availableWidth / CGFloat(params.cellCount)
        return CGSize(width: cellWidth, height: cellWidth * 5/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: params.leftInset, bottom: 10, right: params.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        params.cellSpacing
    }
}
