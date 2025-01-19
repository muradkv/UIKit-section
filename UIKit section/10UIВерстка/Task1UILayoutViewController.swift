//
//  UILayoutViewController.swift
//  UIKit section
//
//  Created by murad on 16.01.2025.
//

import UIKit

class Task1UILayoutViewController: UIViewController {
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 38/255, green: 36/255, blue: 131/255, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations!"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.numberOfLines = 0
        return label
    }()

    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Click Me", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .greenPrimary
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let secondaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Secondary Action", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.greenPrimary, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupAttributedForDescrtiptionLabel()
    }
    
    private func setupUI() {
        [contentView].forEach {
            view.addSubview($0)
        }
        
        [titleLabel, descriptionLabel, submitButton, secondaryButton].forEach {
            contentView.addSubview($0)
        }
        
        view.backgroundColor = .greenPrimary
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(39)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        submitButton.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(51)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(secondaryButton.snp.top).offset(-16)
        }
        
        secondaryButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-32)
        }
        
        // Принудительно обновляем layout
        view.layoutIfNeeded()
        submitButton.layer.cornerRadius = min(self.submitButton.frame.width, self.submitButton.frame.height) / 2
    }
    
    private func setupAttributedForDescrtiptionLabel() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 19.36 / 16 // lineHeight / fontSize
        paragraphStyle.alignment = .center

        let attributedString = NSMutableAttributedString(
            string: "Consequat velit qui adipisicing sunt do reprehenderit ad laborum tempor ullamco exercitation. Ullamco tempor adipisicing et voluptate duis sit esse aliqua esse ex dolore esse. Consequat velit qui adipisicing sunt.!",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .paragraphStyle: paragraphStyle
            ]
        )

        descriptionLabel.attributedText = attributedString
    }

}
