//
//  VerifyPhoneNumberVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit
import Combine

class VerifyPhoneNumberVC: BaseViewController<VerifyPhoneNumberViewModel> {

    lazy var controllerView: VerifyPhoneNumberView = {
        let v = VerifyPhoneNumberView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    lazy var sendCodeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
        btn.addTarget(self, action: #selector(handleSendCodeBtnPressed), for: .touchUpInside)
        btn.isUserInteractionEnabled = false
        return btn
    }()

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.observable.sink { [weak self] in
            guard let self = self else { return }
            self.controllerView.activityView.stopAnimating()
            if !(self.viewModel.error.isEmpty) {
                self.controllerView.updateStyleForTextFields(style: .error)
                self.showError(error: self.viewModel.error)
            }
            if self.viewModel.verified {
                self.showVerificationSuccess()
            }
        }.store(in: &cancellables)
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

    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showVerificationSuccess() {
        controllerView.updateStyleForTextFields(style: .verified)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.viewModel.didVerify()
        }
    }

    @objc func handleSendCodeBtnPressed() {
        sendCodeBtn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
        sendCodeBtn.isUserInteractionEnabled = false
        controllerView.activityView.startAnimating()
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
