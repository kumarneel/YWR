//
//  NoAlarmsHeaderView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/24/22.
//

import UIKit

class NoAlarmsHeaderView: BaseView {

    static let ReusableIdentifier = "NoAlarmsHeaderViewId"

    let roundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 16
        return v
    }()

    let noAlarmsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "You have no alarms 😔"
        lbl.textColor = #colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1)
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 24)
        return lbl
    }()

    override func setupView() {

        backgroundColor = .clear

        [roundView, noAlarmsLabel].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            roundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            roundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            roundView.topAnchor.constraint(equalTo: topAnchor),
            roundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

            noAlarmsLabel.centerYAnchor.constraint(equalTo: roundView.centerYAnchor),
            noAlarmsLabel.leftAnchor.constraint(equalTo: roundView.leftAnchor, constant: 30)
        ])
    }

}
