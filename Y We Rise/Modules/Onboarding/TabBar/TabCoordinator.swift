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
        tabBarController.overrideUserInterfaceStyle = .light

        let settingsNavController = setupSettings()
        let alarmController = setupAlarm()
        let profileNavController = setupProfile()

        tabBarController.setViewControllers([settingsNavController, alarmController, profileNavController], animated: true)
        tabBarController.selectedIndex = 1
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

    func setupAlarm() -> UINavigationController {
        let alarmViewModel = AlarmViewModel()
        alarmViewModel.eventTriggered = { event in
            switch event {
            case .didTapAddNewAlarm:
                break
            }
        }

        let alarmVC = AlarmVC(viewModel: alarmViewModel)
        let navController = UINavigationController(rootViewController: alarmVC)

        navController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "AlarmIconUnfilled"), selectedImage: UIImage(named: "AlarmIconFilled"))
        navController.setNavigationBarHidden(true, animated: false)
        return navController
    }

    func setupProfile() -> UINavigationController {
        let profileViewModel = ProfileViewModel()
        profileViewModel.eventTriggered = { event in
            switch event {
            case .didTapEditMotivation(let motivationStyles):
                self.presentEditMovivation(motivationStyles: motivationStyles)
            case .didTapEditStyle(let sleepStyles):
                self.presentEditSleepStyle(sleepStyles: sleepStyles)
            }
        }
        let profileVC = ProfileVC(viewModel: profileViewModel)
        let navController = UINavigationController(rootViewController: profileVC)

        navController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ProfileIconUnfilled"), selectedImage: UIImage(named: "ProfileIconFilled"))
        navController.setNavigationBarHidden(true, animated: false)

        return navController

    }

    func presentEditMovivation(motivationStyles: [String]) {
        let viewModel = MotivationStyleViewModel(isEditing: true, motivation_styles: motivationStyles)
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapNext:
                self.navigationController.popViewController(animated: true)
            }
        }
        let viewController = MotivationStyleVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func presentEditSleepStyle(sleepStyles: [String]) {
        let viewModel = SleepStyleViewModel(isEditing: true, sleep_styles: sleepStyles)
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapNext:
                self.navigationController.popViewController(animated: true)
            }
        }
        let viewController = SleepStyleVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

}
