//
//  SetAlarmVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/25/22.
//

import UIKit

class SetAlarmVC: BaseViewController<SetAlarmViewModel> {

    lazy var controllerView: SetAlarmView = {
        let v = SetAlarmView()
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

    @objc func didTapBackBtn() {
        viewModel.didTapBackBtn()
    }
}

extension SetAlarmVC {
    func setupViewController() {
        addControllerView(controllerView)
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "YWRBackButtonIcon"), style: .plain, target: self, action: #selector(didTapBackBtn))
    }
}
