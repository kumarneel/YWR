//
//  VerificationCodeTextField.swift
//  Tres
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

enum StyleType {
    case typing
    case verified
    case error
}

protocol VerificationCodeTextFieldDelegate: AnyObject {
    func didTapTextFieldDelete(_ textField: UITextField)
}

class VerificationTextField: UITextField {

    weak var deleteDelegate: VerificationCodeTextFieldDelegate?

    func setupTextField() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        backgroundColor = UIColor(named: "YWRCreamDarkened")
        font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        placeholder = "0"
        layer.borderWidth = 2
        keyboardType = .numberPad
        textColor = .black
        textAlignment = .center
    }

    func changeStyle(styleType: StyleType) {
        switch styleType {
        case .typing:
            layer.borderColor = UIColor.clear.cgColor
            textColor = .black
        case .verified:
            layer.borderColor = UIColor.green.cgColor
            textColor = .green
        case .error:
            layer.borderColor = UIColor(named: "YWRRed")?.cgColor
            textColor = UIColor(named: "YWRRed")
        }
    }

    override func deleteBackward() {
        super.deleteBackward()
        deleteDelegate?.didTapTextFieldDelete(self)
    }
}
