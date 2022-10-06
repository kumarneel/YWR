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

    lazy var sendCodeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
        btn.addTarget(self, action: #selector(handleSendCodeBtnPressed), for: .touchUpInside)
        btn.isUserInteractionEnabled = true
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            view.addSubview(sendCodeBtn)

            NSLayoutConstraint.activate([
                sendCodeBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
                sendCodeBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (-25 - keyboardHeight)),
                sendCodeBtn.heightAnchor.constraint(equalToConstant: 42),
                sendCodeBtn.widthAnchor.constraint(equalToConstant: 42)
            ])
        }
    }

    @objc func handleSendCodeBtnPressed() {
        viewModel.didTapVerifyCode()
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
