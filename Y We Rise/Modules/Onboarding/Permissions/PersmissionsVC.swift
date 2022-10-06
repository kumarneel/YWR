//
//  PersmissionsVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

class PersmissionsVC: BaseViewController<PermissionsViewModel> {

    lazy var controllerView: PermissionsView = {
        let v = PermissionsView()
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

extension PersmissionsVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}
