//
//  SceneDelegate.swift
//  PlantAppTransition
//
//  Created by cleanmac on 08/07/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let homeVC = HomeViewController()
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
    }

}

