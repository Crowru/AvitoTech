//
//  ViewController.swift
//  AvitoTech_ios
//
//  Created by Руслан  on 24.08.2023.
//

import UIKit

final class ListOfAdvertisementsViewController: UIViewController & ListOfAdvertisementsViewControllerProtocol {
    var presenter: ListOfAdvertisementsPresenterProtocol?
    
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    init(presenter: ListOfAdvertisementsPresenterProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let params = GeometryParams(cellCount: 2, leftInset: 15, rightInset: 15, cellSpacing: 10)
        
    var listOfProductsService = ListOfAdvertisementsService.shared
    
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
        presenter?.getData()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.navigationBar.layoutIfNeeded()
        }
    }
    
    private func setupCollectionView() {
        navigationController?.navigationBar.barTintColor = .white
        collectionView.backgroundColor = .white
        collectionView.indicatorStyle = .black
        navigationItem.title = "Товары"
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListOfAdvertisementsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListOfAdvertisementsCell.identifier, for: indexPath) as? ListOfAdvertisementsCell, let item = presenter?.items?[indexPath.row] else { return }
        navigationController?.pushViewController(AdvertisementsDetailsViewController(), animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension ListOfAdvertisementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let countOfProducts = presenter?.items?.count else { return 0 }
        return countOfProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListOfAdvertisementsCell.identifier, for: indexPath) as? ListOfAdvertisementsCell, let item = presenter?.items?[indexPath.row] else { return UICollectionViewCell() }
        cell.setupCell(from: item)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ListOfAdvertisementsViewController: UICollectionViewDelegateFlowLayout {
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
