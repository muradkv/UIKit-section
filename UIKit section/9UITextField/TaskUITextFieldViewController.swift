//
//  TaskUITextFieldViewController.swift
//  UIKit section
//
//  Created by murad on 15.01.2025.
//

import UIKit

enum AlertError {
    case success
    case failure
}

class TaskUITextFieldViewController: UIViewController {
    
    private let login = UITextField()
    private let password = UITextField()
    private let submitButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTapGestureToDismissKeyboard()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        login.frame.size = CGSize(width: 280, height: 40)
        login.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        login.placeholder = "Введите ваш логин"
        login.font = UIFont.systemFont(ofSize: 16)
        login.borderStyle = .roundedRect
        login.autocorrectionType = .no
        login.keyboardType = .emailAddress
        login.returnKeyType = .done
        login.clearButtonMode = .whileEditing
        login.contentVerticalAlignment = .center
        login.delegate = self
        view.addSubview(login)
        
        password.frame.size = CGSize(width: 280, height: 40)
        password.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY + 80)
        password.placeholder = "Введите ваш пароль"
        password.font = UIFont.systemFont(ofSize: 16)
        password.borderStyle = .roundedRect
        password.autocorrectionType = .no
        password.keyboardType = .emailAddress
        password.returnKeyType = .done
        password.clearButtonMode = .whileEditing
        password.contentVerticalAlignment = .center
        password.isSecureTextEntry = true 
        password.delegate = self
        view.addSubview(password)
        
        submitButton.frame.size = CGSize(width: 60, height: 46)
        submitButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY + 150)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
    }
    
    private func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        // Скрыть клавиатуру по нажатию на область мимо текстфилд:
        view.endEditing(true)
    }
    
    @objc private func submitButtonTapped() {
        guard let login = login.text, login.isEmpty == false else {
            showAlert(state: .failure, message: "Введите логин")
            return
        }
        
        guard let passwordText = password.text, passwordText.isEmpty == false else {
            showAlert(state: .failure, message: "Введите пароль")
            return
        }
        
        if isValidPassword(passwordText) {
            showAlert(state: .success, message: "")
        } else {
            showAlert(state: .failure, message: "Пароль должен содержать буквы, цифры, а также минимум 8 символов")
        }
        
        view.endEditing(true)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-zА-Яа-я])(?=.*\\d)[A-Za-zА-Яа-я\\d]{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordPred.evaluate(with: password)
        
        return result
    }
    
    private func showAlert(state: AlertError, message: String) {
        var alert = UIAlertController()
        
        switch state {
        case .success:
            alert = UIAlertController(title: "Успешная авторизация", message: message, preferredStyle: .alert)
        case .failure:
            alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension TaskUITextFieldViewController: UITextFieldDelegate {
    // Скрыть клавиатуру по нажатию на кнопку возврата:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == login {
            // Переключаем фокус на password
            password.becomeFirstResponder()
        } else if textField == password {
            // Закрываем клавиатуру
            textField.resignFirstResponder()
        }
    
        return true
    }
}

