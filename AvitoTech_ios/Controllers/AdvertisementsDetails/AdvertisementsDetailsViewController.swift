//
//  AdvertisementsDetailsViewController.swift
//  AvitoTech
//
//  Created by Руслан  on 27.08.2023.
//

import UIKit
import Kingfisher

final class AdvertisementsDetailsViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport-Bold", size: 30)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport-Bold", size: 15)
        label.numberOfLines = 5
        label.textColor = .black
        return label
    }()
    
    private let location: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport", size: 15)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let phoneNumber: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Aeroport", size: 15)
        label.textColor = .black
        label.backgroundColor = .clear
        label.isEditable = false
        return label
    }()
    
    private let email: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Aeroport", size: 15)
        label.textColor = .black
        label.backgroundColor = .clear
        label.isEditable = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport-Bold", size: 25)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let descriptionText: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Aeroport", size: 15)
        label.textColor = .black
        label.backgroundColor = .clear
        label.isEditable = false
        return label
    }()
    
    private let createdDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport-Light", size: 13)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    var presenter: AdvertisementsDetailsPresenter
    
    init(service: ListOfAdvertisementsServiceProtocol, detailId: String) {
        self.presenter = AdvertisementsDetailsPresenter(service: service, detailId: detailId)
        self.presenter.fetchDetailInfo()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        checkInternetHandler()
    }
    
    private func checkInternetHandler() {
        if ConnectedToNetwork.isConnectedToNetwork() {
            setupView()
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
                DispatchQueue.main.async {
                    UIBlockingProgressHUD.dismiss()
                    self.populateData()
                }
            case .error(let error):
                DispatchQueue.main.async {
                    UIBlockingProgressHUD.dismiss()
                    print(error)
                    self.presentErrorAlert(message: "Потеряно соединение с интернетом", retryHandler: {
                        self.presenter.fetchDetailInfo()
                        self.checkInternetHandler()
                    })
                }
            case nil: break
            case .some(.none): break
            }
        }
    }
    
    private func setupView() {
        [imageView, price, titleLabel, location, phoneNumber, email, descriptionLabel, descriptionText, createdDate].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.width),
            
            price.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            price.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            price.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            titleLabel.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            location.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            location.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            location.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            phoneNumber.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 5),
            phoneNumber.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            phoneNumber.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            phoneNumber.heightAnchor.constraint(equalToConstant: 40),
            
            email.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 0),
            email.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            email.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            email.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 0),
            descriptionText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            descriptionText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            descriptionText.heightAnchor.constraint(equalToConstant: 60),
            
            createdDate.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 0),
            createdDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            createdDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    private func populateData() {
        guard let detail = presenter.detail else {
            return
        }
        
        let url = detail.image_url
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.5))]) { result in
            switch result {
            case .success(let image):
                self.imageView.image = image.image
            case .failure(let error):
                print("Ошибка загрузки картинки: \(error)")
            }
        }
        
        titleLabel.text = detail.title
        price.text = formatPrice(detail.price)
        location.text = "\(detail.location), \(detail.address)"
        email.text = detail.email
        phoneNumber.text = detail.phone_number
        descriptionLabel.text = "Описание"
        descriptionText.text = detail.description
        createdDate.text = """
        Объявление №\(detail.id)
        \(convertDate(from: detail.created_date))
        """
    }
}
