//
//  ContinueOptionButton.swift
//  UIKit section
//
//  Created by murad on 18.01.2025.
//

import UIKit

class ContinueOptionButton: UIButton {
    
    //MARK: - Properties
    
    private let imageViewButton = UIImageView()
    private let titleLabelButton = UILabel()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage?, text: String) {
        self.init()
        imageViewButton.image = image
        titleLabelButton.text = text
    }
    
    //MARK: - Methods
    
    private func embedViews() {
        [imageViewButton, titleLabelButton].forEach { view in
            addSubview(view)
        }
    }
    
    private func setupAppearance() {
        backgroundColor = UIColor(red: 253/255, green: 235/255, blue: 219/255, alpha: 1)
        layer.cornerRadius = 20
        
        imageViewButton.contentMode = .scaleAspectFit
        
        titleLabelButton.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabelButton.textColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        titleLabelButton.textAlignment = .left
    }
    
    private func setupLayout() {
        imageViewButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        titleLabelButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageViewButton.snp.trailing).offset(16)
        }
        
        snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
}
