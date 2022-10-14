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
        // TODO: Add actual firestore auth here
        AppCoordinator.init(navigationController: rootController).start(userIsLoggedIn: Auth.auth().currentUser != nil)
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
}

