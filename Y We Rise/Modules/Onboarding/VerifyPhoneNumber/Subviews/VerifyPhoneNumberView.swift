//
//  VerifyPhoneNumberView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class VerifyPhoneNumberView: BaseView {

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Enter the code"
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 32)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "You should have just received a\nverification code. Please enter that here."
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()

    lazy var codeTextField1: VerificationTextField = {
        let tf = VerificationTextField()
        tf.setupTextField()
        tf.tag = 1
        tf.deleteDelegate = self
        tf.delegate = self
        return tf
    }()

    lazy var codeTextField2: VerificationTextField = {
        let tf = VerificationTextField()
        tf.setupTextField()
        tf.deleteDelegate = self
        tf.delegate = self
        tf.tag = 2
        return tf
    }()

    lazy var codeTextField3: VerificationTextField = {
        let tf = VerificationTextField()
        tf.setupTextField()
        tf.deleteDelegate = self
        tf.delegate = self
        tf.tag = 3
        return tf
    }()

    lazy var codeTextField4: VerificationTextField = {
        let tf = VerificationTextField()
        tf.setupTextField()
        tf.deleteDelegate = self
        tf.delegate = self
        tf.tag = 4
        return tf
    }()

    lazy var codeTextField5: VerificationTextField = {
        let tf = VerificationTextField()
        tf.setupTextField()
        tf.deleteDelegate = self
        tf.delegate = self
        tf.tag = 5
        return tf
    }()

    lazy var codeTextField6: VerificationTextField = {
        let tf = VerificationTextField()
        tf.setupTextField()
        tf.deleteDelegate = self
        tf.delegate = self
        tf.tag = 6
        return tf
    }()

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override func setupView() {
        backgroundColor = UIColor(named: "YWRCream")!

        [titleLbl, subtitleLbl, stackView].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            titleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: 30),

            subtitleLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor),
            subtitleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            subtitleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),

            stackView.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 60),
            stackView.heightAnchor.constraint(equalToConstant: 65),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),

        ])

        // setup 6 different textfields
        NSLayoutConstraint.activate([
            codeTextField1.heightAnchor.constraint(equalToConstant: 65),
            codeTextField2.heightAnchor.constraint(equalToConstant: 65),
            codeTextField3.heightAnchor.constraint(equalToConstant: 65),
            codeTextField4.heightAnchor.constraint(equalToConstant: 65),
            codeTextField5.heightAnchor.constraint(equalToConstant: 65),
            codeTextField6.heightAnchor.constraint(equalToConstant: 65)

        ])

        [codeTextField1, codeTextField2, codeTextField3, codeTextField4, codeTextField5, codeTextField6].forEach({stackView.addArrangedSubview($0)})

        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 7

        codeTextField1.becomeFirstResponder()
    }

    func updateStyleForTextFields(style: StyleType) {
        [codeTextField1, codeTextField2, codeTextField3, codeTextField4, codeTextField5, codeTextField6].forEach({$0.changeStyle(styleType: style)})
    }
}

extension VerifyPhoneNumberView: VerificationCodeTextFieldDelegate, UITextFieldDelegate {
    /// handle delete single number
    func didTapTextFieldDelete(_ textField: UITextField) {
        updateStyleForTextFields(style: .typing)
        if textField == codeTextField1 {
            codeTextField1.text = nil
        } else if textField == codeTextField2 {
            codeTextField2.text = nil
            codeTextField1.becomeFirstResponder()
        } else if textField == codeTextField3 {
            codeTextField3.text = nil
            codeTextField2.becomeFirstResponder()
        } else if textField == codeTextField4 {
            codeTextField4.text = nil
            codeTextField3.becomeFirstResponder()
        } else if textField == codeTextField5 {
            codeTextField5.text = nil
            codeTextField4.becomeFirstResponder()
        } else if textField == codeTextField6 {
            codeTextField6.text = nil
            codeTextField5.becomeFirstResponder()
        }
    }

    /// handle enter number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string != "") {
            if (textField.text == "") {
                updateStyleForTextFields(style: .typing)
                textField.text = string
                let nextResponder: UIResponder? = viewWithTag(textField.tag + 1)
                if (nextResponder != nil) {
                    nextResponder?.becomeFirstResponder()
                }else {
                    // TODO: send code
//                    handleSendCodeBtn()
                }

            }else {
                // typing with code already in textfield edge case
                let nextResponder: UIResponder? = viewWithTag(textField.tag + 1)
                if (nextResponder != nil) {
                    nextResponder?.becomeFirstResponder()
                }

            }
            return false
        }
        return true
    }
}
