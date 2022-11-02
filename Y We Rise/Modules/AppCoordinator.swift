//
//  AppCoordinator.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/3/22.
//

import UIKit

class AppCoordinator {
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(userIsLoggedIn: Bool) {
//        userIsLoggedIn ? presentTabBar() : presentOnboarding()
        presentOnboarding()
    }

    private func presentOnboarding() {
        let coordinator = OnboardingCoordinator.init(navigationController: navigationController)
        coordinator.userSignedUpTriggered = {
            self.navigationController.popToRootViewController(animated: false)
            self.presentTabBar()
        }
        coordinator.start()
    }

    private func presentTabBar() {
        let coordinator = TabBarCoordinator.init(navigationController: navigationController)
        coordinator.userLoggedOutTriggered = {
            self.navigationController.popToRootViewController(animated: false)
            self.presentOnboarding()
        }
        coordinator.start()

    }
}

