//
//  ImageCollectionCellMod2.swift
//  UIKit section
//
//  Created by murad on 28.01.2025.
//

import UIKit

final class ImageCollectionCellMod2: UICollectionViewCell {
    //MARK: - Properties
    
    let imageView = UIImageView()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI

    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    //MARK: - Methods
    
    func configure(image: UIImage?) {
        imageView.image = image
    }
}
