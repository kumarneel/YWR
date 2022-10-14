//
//  TabCoordinator.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/3/22.
//

import UIKit

class TabBarCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        setupTabBar()
    }

    private func setupTabBar() {
        let tabBarController = UITabBarController()

        let settingsViewModel = SettingsViewModel()
        let settingsVC = SettingsVC(viewModel: settingsViewModel)
        let nv1 = UINavigationController(rootViewController: settingsVC)

        let alarmViewModel = AlarmViewModel()
        let alarmVC = AlarmVC(viewModel: alarmViewModel)
        let nv2 = UINavigationController(rootViewController: alarmVC)


        let profileViewModel = ProfileViewModel()
        let profileVC = ProfileVC(viewModel: profileViewModel)
        let nv3 = UINavigationController(rootViewController: profileVC)

        nv1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SettingsIconUnfilled"), selectedImage: UIImage(named: "SettingsIconFilled"))
        nv2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "AlarmIconUnfilled"), selectedImage: UIImage(named: "AlarmIconFilled"))
        nv3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ProfileIconUnfilled"), selectedImage: UIImage(named: "ProfileIconFilled"))
        
        tabBarController.setViewControllers([nv1, nv2, nv3], animated: true)

        navigationController.viewControllers = [tabBarController]
    }


}
