//
//  OnboardingCoordinator.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/3/22.
//

import UIKit

class OnboardingCoordinator {

    var userSignedUpTriggered: (() -> Void)?

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        presentGetStarted()
    }

    private func presentGetStarted() {
        let viewModel = GetStartedViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapGetStarted:
                self.presentEnterPhoneNumber()
            }
        }
        let viewController = GetStartedVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

    private func presentEnterPhoneNumber() {
        let viewModel = EnterPhoneNumberViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapBackBtn:
                self.navigationController.popViewController(animated: true)
            case .didTapSendCode:
                self.presentVerifyPhoneNumber()
            }
        }
        let viewController = EnterPhoneNumberVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentVerifyPhoneNumber() {
        let viewModel = VerifyPhoneNumberViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapBackBtn:
                self.navigationController.popViewController(animated: true)
            case .didTapVerifyCode:
                self.presentEnterName()
            }
        }
        let viewController = VerifyPhoneNumberVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func presentEnterName() {
        let viewModel = EnterNameViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapSaveName:
                self.presentEnterBirthday()
            }
        }
        let viewController = EnterNameVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentEnterBirthday() {
        let viewModel = EnterBirthdayViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapSaveBirthday:
                self.presentPermissions()
            }
        }
        let viewController = EnterBirthdayVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentPermissions() {
        let viewModel = PermissionsViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case.didTapNext:
                self.presentSleepStyle()
            }
        }
        let viewController = PersmissionsVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentSleepStyle() {
        let viewModel = SleepStyleViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapNext:
                self.presentMotivationStyle()
            }
        }
        let viewController = SleepStyleVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentMotivationStyle() {
        let viewModel = MotivationStyleViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapNext:
                self.presentFirstAlarm()
            }
        }
        let viewController = MotivationStyleVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentFirstAlarm() {
        let viewModel = FirstAlarmViewModel()
        viewModel.eventTriggered = { event in
            switch event {
            case.didTapNext(let alarmString):
                self.presentAddMotiviation(alarmString: alarmString)
            case .didTapSkip:
                self.userSignedUpTriggered?()
            }
        }
        let viewController = FirstAlarmVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentAddMotiviation(alarmString: String) {
        let viewModel = AddMotivationViewModel(alarmString: alarmString)
        viewModel.eventTriggered = { event in
            switch event {
            case .didTapNext:
                self.userSignedUpTriggered?()
            }
        }
        let viewController = AddMotivationVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
