//
//  UIButtonViewController.swift
//  UIKit section
//
//  Created by murad on 06.01.2025.
//

import UIKit

class UIButtonViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Тестовая кнопка", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        button.backgroundColor = .green.withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        
        button.setTitleColor(.magenta, for: .disabled)
        button.isEnabled = false
        
        button.layer.cornerRadius = 12
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(button)
        view.backgroundColor = .brown.withAlphaComponent(0.8)
        
        button.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(250)
            make.height.equalTo(44)
        }
        
        button.addAction(UIAction { action in
            print("hello")
        }, for: .touchUpInside)
    }
}

#Preview(traits: .portrait) {
    UIButtonViewController()
}
