//
//  AlarmCell.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/24/22.
//

import UIKit

class AlarmCell: UITableViewCell {

    static let ReusableIdentifier = "AlarmCellId"

    let roundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 16
        v.backgroundColor = .white
        v.layer.borderColor = UIColor(named: "YWROrange")!.cgColor
        v.layer.borderWidth = 2
        return v
    }()

    let timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "6:30"
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 47)
        lbl.textColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        return lbl
    }()

    let amPMLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "AM"
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 25)
        lbl.textColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        return lbl
    }()

    func setupView() {
        selectionStyle = .none
        backgroundColor = .clear

        [roundView, timeLbl, amPMLbl].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            roundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            roundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            roundView.topAnchor.constraint(equalTo: topAnchor),
            roundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

            timeLbl.centerYAnchor.constraint(equalTo: roundView.centerYAnchor),
            timeLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),

            amPMLbl.leftAnchor.constraint(equalTo: timeLbl.rightAnchor),
            amPMLbl.bottomAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: -5)

        ])
    }

}
