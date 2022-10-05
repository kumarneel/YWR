//
//  EnterNameView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class EnterNameView: BaseView {

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
        lbl.numberOfLines = 1
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

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(named: "YWRCreamDarkened")
        tf.layer.cornerRadius = 15
        tf.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        tf.placeholder = "Name"
        tf.textAlignment = .center
        return tf
    }()

    override func setupView() {

        backgroundColor = UIColor(named: "YWRCream")!

        [onboardingBar, titleLbl, subtitleLbl, nameTextField].forEach({addSubview($0)})

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
            nameTextField.heightAnchor.constraint(equalToConstant: 65)
        ])

        onboardingBar.setupBar(percentage: 0.1425)
    }
}
