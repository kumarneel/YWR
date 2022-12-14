//
//  SleepStyleVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

class SleepStyleVC: BaseViewController<SleepStyleViewModel> {

    lazy var controllerView: SleepStyleView = {
        let v = SleepStyleView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    var selectedSleepStyleArray = [SleepStyle]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
    }
}

extension SleepStyleVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
        controllerView.isEditing = viewModel.isEditing
        controllerView.sleepStyles = viewModel.sleep_styles
    }
}
