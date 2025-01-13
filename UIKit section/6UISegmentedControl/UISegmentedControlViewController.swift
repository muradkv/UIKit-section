//
//  Untitled.swift
//  UIKit section
//
//  Created by murad on 10.01.2025.
//

import UIKit

class UISegmentedControlViewController: UIViewController {
    private let segmentedControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.frame = CGRect(x: 50, y: 100, width: 400, height: 40)
        segmentedControl.center = view.center
        
        // Добавляем первый сегмент
        segmentedControl.insertSegment(withTitle: "AA", at: 0, animated: true)
        segmentedControl.setImage(UIImage(systemName: "star"), forSegmentAt: 0)

        // Добавляем второй сегмент
        segmentedControl.insertSegment(withTitle: "Опция 2", at: 1, animated: true)
        segmentedControl.setImage(UIImage(systemName: "circle"), forSegmentAt: 1)

        // Добавляем третий сегмент
        segmentedControl.insertSegment(withTitle: "Опция 3", at: 2, animated: true)
        segmentedControl.setImage(UIImage(systemName: "square"), forSegmentAt: 2)
        
        
        view.addSubview(segmentedControl)
        
        view.backgroundColor = .systemBackground
    }
}
