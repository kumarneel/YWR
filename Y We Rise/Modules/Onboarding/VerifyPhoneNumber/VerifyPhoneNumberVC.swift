//
//  VerifyPhoneNumberVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class VerifyPhoneNumberVC: BaseViewController<VerifyPhoneNumberViewModel> {

    lazy var controllerView: VerifyPhoneNumberView = {
        let v = VerifyPhoneNumberView()
        v.translatesAutoresizingMaskIntoConstraints = false
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

extension VerifyPhoneNumberVC {
    func setupViewController() {
        addControllerView(controllerView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "YWRBackButtonIcon"), style: .plain, target: self, action: #selector(didTapBackBtn))
    }
}
