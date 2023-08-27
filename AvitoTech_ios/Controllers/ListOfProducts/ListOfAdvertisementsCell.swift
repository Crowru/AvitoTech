//
//  ListOfProductsCell.swift
//  AvitoTech
//
//  Created by Руслан  on 24.08.2023.
//

import UIKit

final class ListOfAdvertisementsCell: UICollectionViewCell {
    
    static let identifier = "AdvertisementCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let createdDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var index = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(price)
        contentView.addSubview(location)
        contentView.addSubview(createdDate)
        imageView.backgroundColor = .systemGray5
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: (contentView.bounds.height) * 3 / 5),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            price.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            location.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 5),
            location.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            createdDate.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 5),
            createdDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            createdDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        
        let imageURLPath = "https://www.avito.st/s/interns-ios/images/\(index).png"
        index += 1
        let imageURL = URL(string: imageURLPath)!
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    
    }
    
    
}
