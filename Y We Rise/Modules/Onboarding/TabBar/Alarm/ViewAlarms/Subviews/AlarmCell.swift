//
//  AlarmCell.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/24/22.
//

import UIKit

class AlarmCell: UITableViewCell {

    static let ReusableIdentifier = "AlarmCellId"

    var alarm: Alarm? {
        didSet {
            guard let alarm = alarm else { return }
            let time = alarm.alarm.dropLast(2)
            let amPMString = String(alarm.alarm.suffix(2))

            timeLbl.text = String(time)
            amPMLbl.text = amPMString

            if alarm.isActive {
                roundView.layer.borderWidth = 2
                alarmSwitch.isOn = true
            }
        }
    }

    let roundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 16
        v.backgroundColor = .white
        v.layer.borderColor = UIColor(named: "YWROrange")!.cgColor
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

    let alarmSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        return sw
    }()

    func setupView() {
        selectionStyle = .none
        backgroundColor = .clear

        [roundView, timeLbl, amPMLbl, alarmSwitch].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            roundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            roundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            roundView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            roundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            timeLbl.centerYAnchor.constraint(equalTo: roundView.centerYAnchor),
            timeLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 52),

            amPMLbl.leftAnchor.constraint(equalTo: timeLbl.rightAnchor),
            amPMLbl.bottomAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: -5),

            alarmSwitch.centerYAnchor.constraint(equalTo: roundView.centerYAnchor),
            alarmSwitch.rightAnchor.constraint(equalTo: roundView.rightAnchor, constant: -30),
            alarmSwitch.heightAnchor.constraint(equalToConstant: 37),
            alarmSwitch.widthAnchor.constraint(equalToConstant: 74)
        ])
    }

    @objc func switchValueDidChange(_ sender: UISwitch) {
        guard let alarm = alarm else { return }
        AlarmService.instance.changeActiveStatus(isActive: sender.isOn, alarmString: alarm.alarm)
        if sender.isOn {
            roundView.layer.borderWidth = 2
        } else {
            roundView.layer.borderWidth = 0
        }
    }

    override func prepareForReuse() {
        alarm = nil
        roundView.layer.borderWidth = 0
        alarmSwitch.isOn = false
    }

}
