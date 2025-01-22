//
//  SceneDelegate.swift
//  UIKit section
//
//  Created by murad on 04.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let imageSaver = UserDefaultsSaver<Data>()
        let textSaver = UserDefaultsSaver<String>()
        
        let imageService = UserDefaultsImageService(dataSaver: imageSaver)
        let textService = UserDefaultsTextService(dataSaver: textSaver)
        let profileService = ProfileService(
            imageService: imageService,
            textService: textService
        )
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TaskUIStackViewViewController(profileService: profileService)
        window?.makeKeyAndVisible() 
    }
}

