//
//  PhotoCollectionViewCell.swift
//  UIKit section
//
//  Created by murad on 25.01.2025.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let photoImageView = UIImageView()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI

    private func setup() {
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            photoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
