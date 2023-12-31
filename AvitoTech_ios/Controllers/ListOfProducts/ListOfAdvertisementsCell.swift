//
//  ListOfProductsCell.swift
//  AvitoTech
//
//  Created by Руслан  on 24.08.2023.
//

import UIKit
import Kingfisher

final class ListOfAdvertisementsCell: UICollectionViewCell {
    static let identifier = "AdvertisementCell"
    
    private let cache = ImageCache.default
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport", size: 15)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport-Bold", size: 16)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let location: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport", size: 12)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let createdDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Aeroport-Light", size: 12)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cache.clearMemoryCache()
        cache.clearDiskCache()
        
        [imageView, titleLabel, price, location, createdDate].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
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
    
    override func prepareForReuse() {
        imageView.kf.cancelDownloadTask()
    }
    
    func setupCell(from model: Items) {
        let url = model.image_url
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.5))]) { result in
            switch result {
            case .success(let image):
                self.imageView.image = image.image
            case .failure(let error):
                print("Ошибка загрузки картинки: \(error)")
            }
        }
        titleLabel.text = model.title
        price.text = formatPrice(model.price)
        location.text = model.location
        createdDate.text = convertDate(from: model.created_date)
    }
}
