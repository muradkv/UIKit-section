//
//  UIImageViewController.swift
//  UIKit section
//
//  Created by murad on 07.01.2025.
//

import UIKit

class UIImageViewController: UIViewController {
    private var imageView = UIImageView()
    private let url = URL(string: "https://yastatic.net/naydex/yandex-search/Q6GB3NM58/51b89390/AD2J99BvXt66tyLQh_782TSAp0Jsl0s6WRq_6r1aa3Y09Hxw5PxFG3WOdD1p6yjOOvzz1M08yyIK577zpGwOgXN_HMcTjY34SESRF0T8nquVQTdDrZX8M")

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        guard let url = url else {
            return
        }
        
        loadImage(from: url) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    private func setupUI() {
        imageView = UIImageView(frame: CGRect(x: view.center.x - 150, y: view.center.y - 150, width: 300, height: 300))
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(nil)
                return print("Error - \(String(describing: error))")
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Не удалось создать изображение из данных")
                completion(nil)
            }
        }
        
        task.resume()
    }
}

#Preview(traits: .portrait) {
    UIImageViewController()
}
