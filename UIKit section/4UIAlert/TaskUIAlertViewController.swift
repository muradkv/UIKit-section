//
//  TaskUIAlertViewController.swift
//  UIKit section
//
//  Created by murad on 08.01.2025.
//

import UIKit

class TaskUIAlertViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Alert", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        
        button.layer.cornerRadius = 12
        return button
    }()
    
    private var savedName = ""
    private var savedPassword = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        [nameLabel, passwordLabel, button].forEach { views in
            view.addSubview(views)
        }
        
        view.backgroundColor = .systemBackground
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-150)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(112)
            make.height.equalTo(44)
        }
        
        button.addAction(UIAction { action in
            self.showAlert()
        }, for: .touchUpInside)
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Введите пароль",
            message: "Для продолжения необходимо заполнить анкету",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        let confirmAction = UIAlertAction(title: "Подтвердить", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
                  let name = textField.text,
                  !name.isEmpty
            else {
                self.nameLabel.text = "Введите имя"
                return
            }
            
            guard let textField = alert.textFields?.last,
                  let password = textField.text,
                  !password.isEmpty
            else {
                self.passwordLabel.text = "Введите пароль"
                return
            }
            
            self.checkPassword(name: name, password: password)
        }
        
        alert.addAction(confirmAction)
        
        alert.preferredAction = confirmAction
        
        alert.addTextField { textField in
            textField.placeholder = "Имя"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Пароль"
            textField.isSecureTextEntry = true
        }
        
        present(alert, animated: true)
    }
    
    private func checkPassword(name: String, password: String) {
        if savedName == name {
            if savedPassword == password {
                passwordLabel.text = "Пароль успешно введён"
            } else {
                passwordLabel.text = "Пароль некорректный"
            }
        } else {
            savedName = name
            savedPassword = password
            
            nameLabel.text = savedName
            passwordLabel.text = "Пароль успешно сохранен"
        }
    }
}

#Preview {
    TaskUIAlertViewController()
}
