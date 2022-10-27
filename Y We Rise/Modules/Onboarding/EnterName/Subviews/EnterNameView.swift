//
//  EnterNameView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

protocol EnterNameViewDelegate: AnyObject {
    func didChangeText(text: String, canProceed: Bool)
}

class EnterNameView: BaseView {

    weak var delegate: EnterNameViewDelegate?

    let onboardingBar: OnboardingOrangeBar = {
        let v = OnboardingOrangeBar()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 3
        return v
    }()

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "What's your first\nname?"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 28)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is used to create your account."
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()

    let nameTextField: PaddingTextField = {
        let tf = PaddingTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(named: "YWRCreamDarkened")
        tf.layer.cornerRadius = 15
        tf.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        tf.placeholder = "Name"
        tf.textAlignment = .left
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.layer.borderWidth = 3
        tf.layer.borderColor = UIColor.clear.cgColor
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        return tf
    }()

    let textErrorLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.9490196078, green: 0.5450980392, blue: 0, alpha: 0.5)
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.text = "No special characters or emojis!"
        lbl.isHidden = true
        lbl.numberOfLines = 2
        return lbl
    }()

    override func setupView() {

        backgroundColor = UIColor(named: "YWRCream")!

        [onboardingBar,
         titleLbl,
         subtitleLbl,
         nameTextField,
         textErrorLbl].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            onboardingBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            onboardingBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            onboardingBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            onboardingBar.heightAnchor.constraint(equalToConstant: 7),

            titleLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            titleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: 30),

            subtitleLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor),
            subtitleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            subtitleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),

            nameTextField.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 65),
            nameTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            nameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 65),

            textErrorLbl.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            textErrorLbl.leftAnchor.constraint(equalTo: nameTextField.leftAnchor)
        ])

        nameTextField.becomeFirstResponder()
        onboardingBar.setupBar(percentage: 0.1425)

        addActivityView()
    }

    @objc func handleTextChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstvuwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if text.rangeOfCharacter(from: characterSet.inverted) != nil {
            textErrorLbl.text = "No numbers, special characters\nor emojis!"
            textErrorLbl.isHidden = false
            nameTextField.layer.borderColor = UIColor(named: "YWROrange")!.cgColor
        }  else if text.count > 20 || text.count < 2 {
            textErrorLbl.text = "Name must be between\n2 and 20 Characters"
            textErrorLbl.isHidden = false
            nameTextField.layer.borderColor = UIColor(named: "YWROrange")!.cgColor
        } else {
            textErrorLbl.isHidden = true
            nameTextField.layer.borderColor = UIColor.clear.cgColor
        }
        delegate?.didChangeText(text: text, canProceed: textErrorLbl.isHidden)
    }
}
