//
//  UIPickerViewController.swift
//  UIKit section
//
//  Created by murad on 10.01.2025.
//

import UIKit

class UIPickerViewController: UIViewController {
    
    private let pickerView = UIPickerView()
    private let data = ["Apple", "Banana", "Cherry", "Date", "Fig", "Grape", "asdasdasdasdasdasd"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.center = view.center
        
//        pickerView.layer.borderWidth = 2
//        pickerView.layer.borderColor = UIColor.brown.cgColor
//        pickerView.backgroundColor = .blue
        
        view.addSubview(pickerView)
        view.backgroundColor = .systemBackground
    }
}

extension UIPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Выбран фрукт: \(data[row])")
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = data[row]
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .darkGray
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        300
    }
}
