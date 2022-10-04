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
        let view = GetStartedView()
        let viewController = GetStartedVC(viewModel: viewModel, view: view)
        navigationController.pushViewController(viewController, animated: false)
    }

    private func presentEnterPhoneNumber() {

    }

}
