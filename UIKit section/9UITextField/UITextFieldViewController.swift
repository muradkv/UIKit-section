//
//  UITextFieldViewController.swift
//  UIKit section
//
//  Created by murad on 15.01.2025.
//

import UIKit

class UITextFieldViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupTapOnView()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let textField = UITextField()
        textField.frame.size = CGSize(width: 280, height: 40)
        textField.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        textField.placeholder = "Введите ваш email"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.delegate = self
        view.addSubview(textField)
    }
    
    private func setupTapOnView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        // Скрыть клавиатуру по нажатию на область мимо текстфилд:
        view.endEditing(true)
    }
    
    // Проверка email
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension UITextFieldViewController: UITextFieldDelegate {
    
    // Скрыть клавиатуру по нажатию на кнопку возврата:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, !text.isEmpty else {
            return true
        }
        
        if isValidEmail(textField.text) {
            return true
        } else {
            return false
        }
    }
    
    // Ограничение длины вводимого текста
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = textField.text as NSString? ?? ""
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
