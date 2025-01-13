//
//  UISwitchViewController.swift
//  UIKit section
//
//  Created by murad on 12.01.2025.
//

import UIKit

class UISwitchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let switchControl = UISwitch(frame: CGRect(x: 150, y: 300, width: 0, height: 0))
        switchControl.isOn = true
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        view.addSubview(switchControl)
        
        view.backgroundColor = .systemBackground
        switchControl.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        
    }
    
}
