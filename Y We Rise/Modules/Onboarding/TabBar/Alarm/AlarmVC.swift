//
//  AlarmVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit

class AlarmVC: BaseViewController<AlarmViewModel> {

    lazy var controllerView: AlarmView = {
        let v = AlarmView()
        v.translatesAutoresizingMaskIntoConstraints = false
//        v.delegate = self
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

extension AlarmVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}
