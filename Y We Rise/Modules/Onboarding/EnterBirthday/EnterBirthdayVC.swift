//
//  EnterBirthdayVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class EnterBirthdayVC: BaseViewController<EnterBirthdayViewModel> {

    lazy var controllerView: EnterBirthdayView = {
        let v = EnterBirthdayView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
        btn.addTarget(self, action: #selector(handleNextBtnPressed), for: .touchUpInside)
        btn.isUserInteractionEnabled = false
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
            view.addSubview(nextBtn)

            NSLayoutConstraint.activate([
                nextBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
                nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (-25 - keyboardHeight)),
                nextBtn.heightAnchor.constraint(equalToConstant: 42),
                nextBtn.widthAnchor.constraint(equalToConstant: 42)
            ])
        }
    }

    @objc func handleNextBtnPressed() {
        viewModel.didTapSaveBirthday()
    }
}

extension EnterBirthdayVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}
