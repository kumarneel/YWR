//
//  MotivationStyleVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

class MotivationStyleVC: BaseViewController<MotivationStyleViewModel> {

    lazy var controllerView: MotivationStyleView = {
        let v = MotivationStyleView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    var selectedMotivationStyleArray = [MotivationStyle]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
    }
}

extension MotivationStyleVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
        controllerView.isEditing = viewModel.isEditing
    }
}
