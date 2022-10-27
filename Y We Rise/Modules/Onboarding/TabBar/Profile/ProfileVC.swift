//
//  ProfileVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit
import Combine

class ProfileVC: BaseViewController<ProfileViewModel> {

    lazy var controllerView: ProfileView = {
        let v = ProfileView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    private var cancellables: Set<AnyCancellable> = []

    var didLaunch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()

        if !didLaunch {
            viewModel.viewWillAppear()
            setupObservers()
            controllerView.activityView.startAnimating()
            didLaunch = true
        }
    }

    func setupObservers() {
        viewModel.observable.sink { [weak self] in
            guard let self = self else { return }
            self.controllerView.activityView.stopAnimating()
            self.controllerView.user = self.viewModel.user
        }.store(in: &cancellables)

        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateUserInformation), name: Notification.Name(Observers.updateUserInfo), object: nil)

    }

    @objc func handleUpdateUserInformation() {
        controllerView.activityView.startAnimating()
        viewModel.getUser()
    }

    

}

extension ProfileVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}
