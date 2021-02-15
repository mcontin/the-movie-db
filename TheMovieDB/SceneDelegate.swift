//
//  SceneDelegate.swift
//  TheMovieDB
//
//  Created by Mattia on 10/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = AppCoordinator.shared.rootController
        window?.makeKeyAndVisible()
        
        AppCoordinator.shared.start()
    }

}

