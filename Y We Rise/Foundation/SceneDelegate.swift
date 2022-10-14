//
//  SceneDelegate.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/3/22.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = window else { return }
        let rootController = UINavigationController()
        window.rootViewController = rootController
        AppCoordinator.init(navigationController: rootController).start(userIsLoggedIn: Auth.auth().currentUser != nil)
        self.window = window
        window.makeKeyAndVisible()
    }
}

