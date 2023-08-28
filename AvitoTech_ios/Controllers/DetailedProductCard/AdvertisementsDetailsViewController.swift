//
//  DetailedProductCard.swift
//  AvitoTech
//
//  Created by Руслан  on 27.08.2023.
//

import UIKit

final class AdvertisementsDetailsViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "5 500 ₽"
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 5
        label.textColor = .black
        label.text = "Игровая клавиатура Red Square Keyrox Classic"
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Санкт-Петербург, пр-т Непокоренныхб 74"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Описание"
        return label
    }()
    
    let descriptionText: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Игровая клавиатура Red Square Keyrox Classic (RSQ-20029) в отличном состоянии тихие жёлтые свитчи продаю по ненадобности(купил новую)"
        return label
    }()
    
    let createdDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = """
        Объявление №3254454170
        24 августа 2023, 22:46
        """
        return label
    }()
    
    var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        imageView.backgroundColor = .systemPurple

    }
    
    private func setupView() {
        [imageView, price, titleLabel, location, descriptionLabel, descriptionText, createdDate].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.width),
            
            price.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            price.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            price.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            titleLabel.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            location.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            location.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            location.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            descriptionText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            descriptionText.heightAnchor.constraint(equalToConstant: 80),
            
            createdDate.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 15),
            createdDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            createdDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            

        ])
    }
    
    func setupCell(id: Int) {
        let imageURLPath = "https://www.avito.st/s/interns-ios/images/\(id).png"
        
    
    }
    
}
