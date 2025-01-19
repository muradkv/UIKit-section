//
//  Task2UILayoutViewController.swift
//  UIKit section
//
//  Created by murad on 17.01.2025.
//

import UIKit

final class Task2UILayoutViewController: UIViewController {
    
    //MARK: - Propertries
    
    private let containerView = UIView()
    private let starsStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let submitButton = UIButton(type: .system)
    private let secondaryButton = UIButton(type: .system)
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //1 вариант, возможно layoutIfNeeded избыточна
        view.layoutIfNeeded()
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
    }
    
    //MARK: - Embed views
    
    private func embedViews() {
        view.addSubview(containerView)
        
        [starsStackView, titleLabel, descriptionLabel, submitButton, secondaryButton].forEach {
            containerView.addSubview($0)
        }
        
        (0...4).forEach { _ in
            let imageView = makeStar()
            starsStackView.addArrangedSubview(imageView)
        }
    }
    
    //MARK: - Setup appearance
    
    private func setupAppearance() {
        view.backgroundColor = .greenPrimary
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        setupShadow(for: containerView)
        
        starsStackView.axis = .horizontal
        starsStackView.distribution = .fillEqually
        starsStackView.alignment = .fill
        starsStackView.spacing = 8
        
        titleLabel.text = "Rate our app"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        
        descriptionLabel.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.attributedText = setupAttributedForDescrtiptionLabel()
        
        submitButton.setTitle("I love it!", for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        submitButton.backgroundColor = .greenPrimary
        submitButton.setTitleColor(.white, for: .normal)
        
        secondaryButton.setTitle("Don’t like the app? Let us know.", for: .normal)
        secondaryButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        secondaryButton.setTitleColor(.greenPrimary, for: .normal)
        
        //2 вариант, так как констрейнты выполняются асинхронно, но возможно ошибки в каких-то сценариях
//        DispatchQueue.main.async {
//            self.submitButton.layer.cornerRadius = self.submitButton.frame.height / 2
//        }
    }
    
    //MARK: - Setup layout
    
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.center.equalToSuperview()
        }
        
        starsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
            make.width.equalTo(192)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(starsStackView.snp.bottom).offset(32)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        submitButton.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(51)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(45)
        }
        
        secondaryButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(submitButton.snp.bottom).offset(18)
            make.bottom.equalToSuperview().offset(-32)
        }
    }
    
    //MARK: - Methods
    
    private func setupShadow(for view: UIView) {
        view.layer.shadowColor = UIColor(red: 38/255, green: 36/255, blue: 131/255, alpha: 0.25).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
    }
    
    private func makeStar() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(red: 255/255, green: 184/255, blue: 78/255, alpha: 1)
        return imageView
    }
    
    private func setupAttributedForDescrtiptionLabel() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 19.36 / 16 // lineHeight / fontSize
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(
            string: "Consequat velit qui adipisicing sunt do reprehenderit ad laborum tempor ullamco exercitation. Ullamco tempor adipisicing et voluptate duis sit esse aliqua esse ex dolore esse. Consequat velit qui adipisicing sunt.! ",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .paragraphStyle: paragraphStyle
            ]
        )
        
        return attributedString
    }
    
}
