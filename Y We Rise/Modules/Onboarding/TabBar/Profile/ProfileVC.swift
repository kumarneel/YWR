//
//  ProfileVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit

class ProfileVC: BaseViewController<ProfileViewModel> {

    lazy var controllerView: ProfileView = {
        let v = ProfileView()
        v.translatesAutoresizingMaskIntoConstraints = false
//        v.delegate = self
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
    }
}

extension ProfileVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}
