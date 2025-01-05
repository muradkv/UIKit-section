//
//  ViewController.swift
//  UIKit section
//
//  Created by murad on 04.01.2025.
//

import UIKit
import SnapKit

class UILabelViewController: UIViewController {
    
    private let name = "Oleg"
    private let age = 42
    private let bio = "Oleg working on the most dangerous place in the world in the ZOO with pandas. They are very agressive and can kill with just only eyes"
    private let bulshit = "Nasd asdasd ad dfsf fgtgsa asdf fsfdfsdfadkkro eokft eeokq pwekl l lwerelrwlr fkfkler"
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.backgroundColor = .cyan
        label.numberOfLines = 0
        
        //Уменьшаем шрифт до допустимого значения scaleFactor
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .brown
        setupUI()
    }

    private func setupUI() {
        view.addSubview(label)
        
        label.text = "\(name)\n\(age)\n\(bio)\n\n\(bulshit)"
        
//        let attributed = NSAttributedString(
//            string: bulshit,
//            attributes:
//                [.backgroundColor: UIColor.red]
//        )
        
        let attributed = NSMutableAttributedString(
            string: bulshit,
            attributes:
                [.backgroundColor: UIColor.red]
        )
        
        attributed.addAttributes(
            [.foregroundColor: UIColor.yellow],
            range: NSRange(location: 0, length: 12))
        
        attributed.addAttributes(
            [.foregroundColor: UIColor.blue,
             .backgroundColor: UIColor.gray,
             .font: UIFont.systemFont(ofSize: 33, weight: .heavy)
            ],
            range: NSRange(location: 16, length: 25))
        
        label.attributedText = attributed
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(300)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
    }

}

#Preview(traits: .portrait) {
    UILabelViewController()
}

