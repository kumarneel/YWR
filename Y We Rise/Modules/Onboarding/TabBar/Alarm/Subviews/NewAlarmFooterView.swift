//
//  NewAlarmFooterView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/24/22.
//

import UIKit

class NewAlarmFooterView: BaseView {

    static let ReusableIdentifier = "NewAlarmFooterView"


    let roundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 16
        v.backgroundColor = UIColor(named: "YWROrange")
        return v
    }()

    let newAlarmLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "New Alarm"
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 24)
        lbl.textColor = #colorLiteral(red: 0.9877046943, green: 0.981163919, blue: 0.9719136357, alpha: 1)
        return lbl
    }()

    let addIconImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "NewAlarmIcon")
        return imv
    }()

    override func setupView() {
        backgroundColor = .clear

        [roundView, newAlarmLbl, addIconImageView].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            roundView.topAnchor.constraint(equalTo: topAnchor),
            roundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            roundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),

            newAlarmLbl.centerYAnchor.constraint(equalTo: roundView.centerYAnchor),
            newAlarmLbl.leftAnchor.constraint(equalTo: roundView.leftAnchor, constant: 30),

            addIconImageView.rightAnchor.constraint(equalTo: roundView.rightAnchor, constant: -30),
            addIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            addIconImageView.heightAnchor.constraint(equalToConstant: 20),
            addIconImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
