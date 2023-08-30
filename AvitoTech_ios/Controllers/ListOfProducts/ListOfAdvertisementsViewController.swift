//
//  ViewController.swift
//  AvitoTech_ios
//
//  Created by Руслан  on 24.08.2023.
//

import UIKit

final class ListOfAdvertisementsViewController: UIViewController {
    private let params = GeometryParams(cellCount: 2, leftInset: 15, rightInset: 15, cellSpacing: 10)
    
    var presenter: ListOfAdvertisementsPresenter
    var listOfProductsService = ListOfAdvertisementsService.shared
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ListOfAdvertisementsCell.self, forCellWithReuseIdentifier: ListOfAdvertisementsCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(presenter: ListOfAdvertisementsPresenter) {
        self.presenter = presenter
        self.presenter.getData()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        checkInternetHandler()
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
    
    private func checkInternetHandler() {
        if ConnectedToNetwork.isConnectedToNetwork() {
            setupCollectionView()
            observeAdvertisements()
            observeViewState()
        } else {
            self.presentErrorAlert(message: "Нет соединения с интернетом", retryHandler: {
                self.checkInternetHandler()
            })
        }
    }
    
    private func observeViewState() {
        self.presenter.viewState.bind { state in
            switch state {
            case .loading:
                UIBlockingProgressHUD.show()
            case .loaded:
                break
            case .error(let error):
                DispatchQueue.main.async {
                    UIBlockingProgressHUD.dismiss()
                    print(error)
                    self.presentErrorAlert(message: "Потеряно соединение с интернетом", retryHandler: {
                        self.presenter.getData()
                    })
                }
            case nil: break
            case .some(.none): break
            }
        }
    }
    
    private func observeAdvertisements() {
        presenter.items.bind { [weak self] _ in
            guard let self = self else { return }
            
            if self.presenter.items.value?.isEmpty == false {
                DispatchQueue.main.async {
                    UIBlockingProgressHUD.dismiss()
                    self.collectionView.reloadData()
                    self.navigationItem.title = "Товары"
                }
            }
        }
    }
    
    private func setupCollectionView() {
        navigationController?.navigationBar.barTintColor = .white
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Aeroport-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .bold)
            
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        let largeTitleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Aeroport-Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = largeTitleAttributes
        collectionView.backgroundColor = .white
        collectionView.indicatorStyle = .black
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: UICollectionViewDelegate
extension ListOfAdvertisementsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailId = presenter.items.value?[indexPath.row].id else { return }
        let service = ListOfAdvertisementsService.shared
        let detailViewController = AdvertisementsDetailsViewController(service: service, detailId: detailId)
        navigationController?.pushViewController(detailViewController , animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension ListOfAdvertisementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let countOfProducts = presenter.items.value?.count else { return 0 }
        return countOfProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListOfAdvertisementsCell.identifier, for: indexPath) as? ListOfAdvertisementsCell, let item = presenter.items.value?[indexPath.row] else { return UICollectionViewCell() }
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
