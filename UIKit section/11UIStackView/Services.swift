//
//  Services.swift
//  UIKit section
//
//  Created by murad on 22.01.2025.
//

import UIKit

// 2. Open/Closed Principle (OCP)
// Классы открыты для расширения, но закрыты для модификации

final class UserDefaultsSaver<T>: DataSaver {
    func save(_ data: T, forKey key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func load(forKey key: String) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }
}

final class UserDefaultsImageService {
    private let dataSaver: UserDefaultsSaver<Data>
    
    init(dataSaver: UserDefaultsSaver<Data>) {
        self.dataSaver = dataSaver
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
        if let data = image.pngData() {
            dataSaver.save(data, forKey: key)
        }
    }
    
    func loadImage(forKey key: String) -> UIImage? {
        guard let data = dataSaver.load(forKey: key) else { return nil }
        return UIImage(data: data)
    }
}

final class UserDefaultsTextService {
    private let dataSaver: UserDefaultsSaver<String>
    
    init(dataSaver: UserDefaultsSaver<String>) {
        self.dataSaver = dataSaver
    }
    
    func saveText(_ text: String, forKey key: String) {
        dataSaver.save(text, forKey: key)
    }
    
    func loadText(forKey key: String) -> String? {
        return dataSaver.load(forKey: key)
    }
}

