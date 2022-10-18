//
//  TabCoordinator.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/3/22.
//

import UIKit

class TabBarCoordinator {

    var userLoggedOutTriggered: (() -> Void)?

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        setupTabBar()
    }

    private func setupTabBar() {
        let tabBarController = UITabBarController()

        let settingsNavController = setupSettings()

        let profileNavController = setupProfile()

        let alarmViewModel = AlarmViewModel()
        let alarmVC = AlarmVC(viewModel: alarmViewModel)
        let nv2 = UINavigationController(rootViewController: alarmVC)




        nv2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "AlarmIconUnfilled"), selectedImage: UIImage(named: "AlarmIconFilled"))
        nv2.setNavigationBarHidden(true, animated: false)

        tabBarController.setViewControllers([settingsNavController, nv2, nv3], animated: true)
        tabBarController.selectedIndex = 2
        navigationController.viewControllers = [tabBarController]
    }

    func setupSettings() -> UINavigationController {
        let settingsViewModel = SettingsViewModel()
        settingsViewModel.eventTriggered = { event in
            switch event {
            case .didTapLogout:
                self.userLoggedOutTriggered?()
                break
            }
        }

        let settingsVC = SettingsVC(viewModel: settingsViewModel)
        let navController = UINavigationController(rootViewController: settingsVC)

        navController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SettingsIconUnfilled"), selectedImage: UIImage(named: "SettingsIconFilled"))
        navController.setNavigationBarHidden(true, animated: false)

        return navController
    }

    func setupAlarm() {

    }

    func setupProfile() -> UINavigationController {
        let profileViewModel = ProfileViewModel()
        profileViewModel.eventTriggered = { event in
            switch event {
            case .didTapEditMotivation:
                break
            case .didTapEditStyle:
                break
            }
        }
        let profileVC = ProfileVC(viewModel: profileViewModel)
        let navController = UINavigationController(rootViewController: profileVC)

        navController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ProfileIconUnfilled"), selectedImage: UIImage(named: "ProfileIconFilled"))
        navController.setNavigationBarHidden(true, animated: false)

        return navController

    }

    func presentEditMovivation() {
        
    }

}
