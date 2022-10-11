//
//  FirstAlarmVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/7/22.
//

import UIKit

class FirstAlarmVC: BaseViewController<FirstAlarmViewModel> {

    lazy var controllerView: FirstAlarmView = {
        let v = FirstAlarmView()
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

extension FirstAlarmVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}
