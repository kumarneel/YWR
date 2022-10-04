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
                self.presentEnterFirstName()
            }

        }
        let viewController = VerifyPhoneNumberVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func presentEnterFirstName() {

    }
}
