//
//  SettingsVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit

class SettingsVC: BaseViewController<SettingsViewModel> {

    lazy var controllerView: SettingsView = {
        let v = SettingsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
    }
}

extension SettingsVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}
