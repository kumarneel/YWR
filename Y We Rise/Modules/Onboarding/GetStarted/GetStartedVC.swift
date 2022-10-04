//
//  GetStartedVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class GetStartedVC: BaseViewController<GetStartedViewModel> {

    lazy var controllerView: GetStartedView = {
        let v = GetStartedView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = controllerView
    }
}
