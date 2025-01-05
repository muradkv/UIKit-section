//
//  TaskUILabelVC.swift
//  UIKit section
//
//  Created by murad on 04.01.2025.
//

import UIKit

class TaskUILabelVC: UIViewController {
    private let nameLabel: DefaultLabel = {
        let label = DefaultLabel()
        label.text = "Иван Серый Скуф"
        return label
    }()
    
    private let surnameLabel: DefaultLabel = {
        let label = DefaultLabel()
        label.text = "Петров Васильевич Бородач"
        return label
    }()
    
    private let bioLabel: DefaultLabel = {
        let label = DefaultLabel()
        label.text = "Разработчик, 5 лет опыта."
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        return stackView
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Left", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 75).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        
        return button
    }()
    
    private let centerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Center", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 75).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Right", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 75).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        addTargetsToButtons()
        setupAttributes()
    }
    
    private func addTargetsToButtons() {
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    @objc func leftButtonTapped() {
        nameLabel.textAlignment = .left
        surnameLabel.textAlignment = .left
        bioLabel.textAlignment = .left
    }
    
    @objc func centerButtonTapped() {
        nameLabel.textAlignment = .center
        surnameLabel.textAlignment = .center
        bioLabel.textAlignment = .center
    }
    
    @objc func rightButtonTapped() {
        nameLabel.textAlignment = .right
        surnameLabel.textAlignment = .right
        bioLabel.textAlignment = .right
    }
    
    private func setupAttributes() {
        let attributed = NSMutableAttributedString(string: nameLabel.text!)
        
        let range = NSRange(location: 5, length: 5)
        
        attributed.addAttributes(
            [.backgroundColor: UIColor.red],
            range: range
        )
        nameLabel.attributedText = attributed
    }

    private func setupUI() {
        [nameLabel, surnameLabel, bioLabel, stackView].forEach {
            view.addSubview($0)
        }
        
        [leftButton, centerButton, rightButton].forEach { button in
            stackView.addArrangedSubview(button)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
        
        surnameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
        
        bioLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(surnameLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
}

class DefaultLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 17, weight: .medium)
        numberOfLines = 0
        textAlignment = .center
    }
}

#Preview(traits: .portrait) {
    TaskUILabelVC()
}
