//
//  ProfileHeaderView.swift
//  UIKit section
//
//  Created by murad on 31.01.2025.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    //MARK: - Properties
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods 
    
    func configure(with profileImage: UIImage, name: String, email: String) {
        profileImageView.image = profileImage
        nameLabel.text = name
        emailLabel.text = email
    }
}

//MARK: - SetupL layout

private extension ProfileHeaderView {
    func setupLayout() {
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            
            emailLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

//MARK: - Embed views

private extension ProfileHeaderView {
    func embedViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(emailLabel)
    }
}

//MARK: - Setup appearance

private extension ProfileHeaderView {
    func setupAppearance() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.masksToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        nameLabel.textColor = .white
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.systemFont(ofSize: 20)
        emailLabel.textColor = .white
    }
}
