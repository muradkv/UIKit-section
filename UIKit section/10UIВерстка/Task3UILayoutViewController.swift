//
//  Task3UILayoutViewController.swift
//  UIKit section
//
//  Created by murad on 18.01.2025.
//

import UIKit

class Task3UILayoutViewController: UIViewController {
    
    //MARK: - Propertries
    
    private let titleLabel = UILabel()
    private let resetPasswordLabel = UILabel()
    // Вариант со стандарнтным вью
    //    private let lineView = UIView()
    // Вариант с оптимизацией через отрисовку на Layer
    private let lineLayer = CALayer()
    private let resetMethodPromptLabel = UILabel()
    private let continueOptionStackView = UIStackView()
    
    //Еще вариант через ContainerView() и модель данных 
    private let continueWithEmailButton = ContinueOptionButton(image: UIImage(named: "smsIcon"), text: "Continue with email")
    private let continueWithMobileButton = ContinueOptionButton(image: UIImage(named: "callingIcon"), text: "Continue with mobile")
    private let continueWithSecretQuestionButton = ContinueOptionButton(image: UIImage(named: "messageIcon"), text: "Continue with secret question")
    
    private let policiesAndTermsButton = UIButton(type: .system)
    private let helpButton = UIButton(type: .system)
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Обновляем frame линии при изменении размера экрана
        updateLineLayerFrame()
    }
    
    //MARK: - Embed views
    
    private func embedViews() {
        [
            titleLabel,
            resetPasswordLabel,
            //            lineView,
            resetMethodPromptLabel,
            continueOptionStackView,
            policiesAndTermsButton,
            helpButton
        ].forEach {
            view.addSubview($0)
        }
        
        [
            continueWithEmailButton,
            continueWithMobileButton,
            continueWithSecretQuestionButton
        ].forEach {
            continueOptionStackView.addArrangedSubview($0)
        }
        
        view.layer.addSublayer(lineLayer)
    }
    
    //MARK: - Setup appearance
    
    private func setupAppearance() {
        view.backgroundColor = .systemBackground
        
        titleLabel.text = "Instant"
        titleLabel.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        titleLabel.textColor = UIColor(red: 251/255, green: 133/255, blue: 0/255, alpha: 1)
        
        resetPasswordLabel.text = "Reset your password"
        resetPasswordLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        resetPasswordLabel.textColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        resetPasswordLabel.textAlignment = .center
        
        // Настройка UIView для линии
        //        lineView.backgroundColor = UIColor(red: 251/255, green: 133/255, blue: 0/255, alpha: 1)
        
        // Настройка CALayer для линии
        lineLayer.backgroundColor = UIColor(red: 251/255, green: 133/255, blue: 0/255, alpha: 1).cgColor
        lineLayer.cornerRadius = 0.5
        
        resetMethodPromptLabel.text = "Which method you want to use  to reset your password."
        resetMethodPromptLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        resetMethodPromptLabel.numberOfLines = 0
        resetMethodPromptLabel.textColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        continueOptionStackView.axis = .vertical
        continueOptionStackView.distribution = .fillEqually
        continueOptionStackView.spacing = 24
        
        let attributedStringForPolicies = setUnderlinedTitle("Policies and Terms of condition", color: UIColor(red: 251/255, green: 133/255, blue: 0/255, alpha: 1), textSize: 14)
        policiesAndTermsButton.setAttributedTitle(attributedStringForPolicies, for: .normal)
        
        let attributedStringForHelp = setUnderlinedTitle("Help", color: UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1), textSize: 16)
        helpButton.setAttributedTitle(attributedStringForHelp, for: .normal)
    }
    
    //MARK: - Setup layout
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
        }
        
        resetPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(87)
            make.centerX.equalToSuperview()
        }
        
        //        Настройки UIView линии через констрейнты
        //        lineView.snp.makeConstraints { make in
        //            make.top.equalTo(resetPasswordLabel.snp.bottom).offset(12)
        //            make.centerX.equalToSuperview()
        //            make.height.equalTo(1)
        //            make.horizontalEdges.equalToSuperview().inset(24)
        //        }
        
        resetMethodPromptLabel.snp.makeConstraints { make in
            // Настройки для CALayer c учетом линии
            make.top.equalTo(resetPasswordLabel.snp.bottom).offset(44)
            
            //            Настройки UIView линии через констрейнты
            //            make.top.equalTo(lineView.snp.bottom).offset(32)
            
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        continueOptionStackView.snp.makeConstraints { make in
            make.top.equalTo(resetMethodPromptLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        helpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
        
        policiesAndTermsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(helpButton.snp.top).offset(-12)
        }
    }
    
    //MARK: - Methods
    
    private func setUnderlinedTitle(_ text: String, color: UIColor, textSize: CGFloat) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: textSize, weight: .medium),
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.single.rawValue // Включаем подчеркивание
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
    
    private func updateLineLayerFrame() {
        // Вычисляем положение линии
        let lineY = resetPasswordLabel.frame.maxY + 12 // Отступ от resetPasswordLabel
        let lineHeight: CGFloat = 1 // Высота линии
        let lineWidth = view.bounds.width - 48 // Ширина линии с отступами по 24 с каждой стороны
        
        // Устанавливаем frame для линии
        lineLayer.frame = CGRect(x: 24, y: lineY, width: lineWidth, height: lineHeight)
    }
}
