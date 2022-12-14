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
        tabBarController.tabBar.isHidden = false
        navigationController.viewControllers = [tabBarController]
    }

    func setupSettings() -> UINavigationController {
        let settingsViewModel = SettingsViewModel()
        settingsViewModel.eventTriggered = { event in
            switch event {
            case .didTapLogout:
                self.userLoggedOutTriggered?()
                break
            case .didTapViewAlarm(let alarm):
                self.presentViewAlarm(alarm: alarm)
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
                self.presentSetAlarm()
            case .didTapViewAlarm(let alarm):
                self.presentViewAlarm(alarm: alarm)
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
            case .didTapViewAlarm(let alarm):
                self.presentViewAlarm(alarm: alarm)
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

    private func presentSetAlarm() {
        let viewModel = SetAlarmViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapBackBtn:
                self.navigationController.popViewController(animated: true)
            case .didTapNext(let alarmString, let snoozeTime):
                self.presentAddMotiviation(alarmString: alarmString, snoozeTime: snoozeTime)
            }
        }
        let viewController = SetAlarmVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentAddMotiviation(alarmString: String, snoozeTime: Int) {
        let viewModel = AddMotivationViewModel(alarmString: alarmString, snoozeTime: snoozeTime, isOnboarding: false)
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapNext:
                self.navigationController.popToRootViewController(animated: true)
            case .didTapBackBtn:
                self.navigationController.popViewController(animated: true)
            }
        }
        let viewController = AddMotivationVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentViewAlarm(alarm: Alarm) {
        let viewModel = ViewAlarmViewModel(alarm: alarm)
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapStop, .didTapSnooze:
                self.navigationController.popToRootViewController(animated: true)
            }
        }
        let viewController = ViewAlarmVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
