//
//  ViewAlarmVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/26/22.
//

import UIKit

class ViewAlarmVC: BaseViewController<ViewAlarmViewModel> {

    lazy var controllerView: ViewAlarmView = {
        let v = ViewAlarmView()
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

extension ViewAlarmVC {
    func setupViewController() {
        addControllerView(controllerView)
        controllerView.alarm = viewModel.alarm
    }
}
