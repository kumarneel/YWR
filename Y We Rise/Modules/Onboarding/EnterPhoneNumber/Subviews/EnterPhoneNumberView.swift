//
//  EnterPhoneNumberView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit
import PhoneNumberKit

protocol EnterPhoneNumberViewDelegate: AnyObject {
    func didUpdateTextField(_ text: String)
}

class EnterPhoneNumberView: BaseView {

    weak var delegate: EnterPhoneNumberViewDelegate?

    let activityView: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "What is your phone\nnumber?"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 32)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "We’ll use this to login or create your\naccount!"
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()

    lazy var phoneNumberTextField: MyUSTextField = {
        let textField = MyUSTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "YWRCreamDarkened")
        textField.layer.cornerRadius = 15
        textField.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.withFlag = true
        textField.withPrefix = true
        textField.withExamplePlaceholder = true
        textField.addTarget(self, action: #selector(handlePhoneTextChange), for: .editingChanged)
        return textField
    }()

    let dataRatesLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Standard message and data rates may apply."
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1)
        return lbl
    }()

    let phoneNumberKit = PhoneNumberKit()

    override func setupView() {
        backgroundColor = UIColor(named: "YWRCream")!
        
        [titleLbl, subtitleLbl, phoneNumberTextField, dataRatesLbl].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            titleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: 30),

            subtitleLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor),
            subtitleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            subtitleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),

            phoneNumberTextField.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 62),
            phoneNumberTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            phoneNumberTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 58),

            dataRatesLbl.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 7),
            dataRatesLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            dataRatesLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
        ])

        phoneNumberTextField.becomeFirstResponder()

        addSubview(activityView)

        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc func handlePhoneTextChange(textField: UITextField) {
        delegate?.didUpdateTextField(textField.text!)
    }
}

extension EnterPhoneNumberView: UITextFieldDelegate {

}
