//
//  ProfileService.swift
//  UIKit section
//
//  Created by murad on 22.01.2025.
//

import UIKit

// 4. Interface Segregation Principle (ISP)
// Клиенты не должны зависеть от методов, которые они не используют

protocol ProfileServiceProtocol {
    func saveProfile(image: UIImage?, name: String?, bio: String?)
    func loadProfile() -> (image: UIImage?, name: String?, bio: String?)
}

// 5. Dependency Inversion Principle (DIP)
// Зависимости от абстракций, а не конкретных реализаций

final class ProfileService: ProfileServiceProtocol {
    private enum Keys {
        static let image = "profileImage"
        static let name = "userName"
        static let bio = "userBio"
    }
    
    private let imageService: UserDefaultsImageService
    private let textService: UserDefaultsTextService
    
    init(imageService: UserDefaultsImageService, textService: UserDefaultsTextService) {
        self.imageService = imageService
        self.textService = textService
    }
    
    func saveProfile(image: UIImage?, name: String?, bio: String?) {
        if let image = image {
            imageService.saveImage(image, forKey: Keys.image)
        }
        if let name = name {
            textService.saveText(name, forKey: Keys.name)
        }
        if let bio = bio {
            textService.saveText(bio, forKey: Keys.bio)
        }
    }
    
    func loadProfile() -> (image: UIImage?, name: String?, bio: String?) {
        let image = imageService.loadImage(forKey: Keys.image)
        let name = textService.loadText(forKey: Keys.name)
        let bio = textService.loadText(forKey: Keys.bio)
        return (image, name, bio)
    }
}
