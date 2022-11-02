//
//  SetAlarmView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/25/22.
//

import UIKit

protocol SetAlarmViewDelegate: AnyObject {
    func didTapNext(alarmString: String, snoozeTime: Int)
}

class SetAlarmView: BaseView {

    weak var delegate: SetAlarmViewDelegate?

    let setAlarmLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Set Alarm"
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 24)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Alarms repeat daily, but you can turn them\noff from the alarm screen."
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = #colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1)
        return lbl
    }()

    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()

    let snoozeLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Snooze Timer"
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 24)
        return lbl
    }()

    let snoozeSubtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is how long it will take for the alarm\nto go off again after you click snooze!"
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = #colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1)
        return lbl
    }()

    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.4666666667, blue: 0, alpha: 0.12)
        btn.setTitle("Next", for: .normal)
        btn.addTarget(self, action: #selector(handleNextBtnPressed), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 24)
        btn.setTitleColor(#colorLiteral(red: 0.9843137255, green: 0.9764705882, blue: 0.9647058824, alpha: 1), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    lazy var fiveMinuteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        btn.setTitle("5 min", for: .normal)
        btn.addTarget(self, action: #selector(handleFiveBtnPressed), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 24)
        btn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)
        return btn
    }()

    lazy var tenMinuteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        btn.setTitle("10 min", for: .normal)
        btn.addTarget(self, action: #selector(handleTenBtnPressed), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 24)
        btn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)
        return btn
    }()

    lazy var fifteenMinBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        btn.setTitle("15 min", for: .normal)
        btn.addTarget(self, action: #selector(handleFifteenBtnPressed), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 24)
        btn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)
        return btn
    }()

    var alarmString: String = "1:00AM"

    var snoozeTime = 0

    override func setupView() {
        backgroundColor = UIColor(named: "YWRCream")

        [setAlarmLbl,
         subtitleLbl,
         pickerView,
         snoozeLbl,
         snoozeSubtitleLbl,
         stackView,
         nextBtn
        ].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            setAlarmLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            setAlarmLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),

            subtitleLbl.topAnchor.constraint(equalTo: setAlarmLbl.bottomAnchor),
            subtitleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            subtitleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),

            pickerView.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor),
            pickerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            pickerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            pickerView.heightAnchor.constraint(equalToConstant: 220),

            snoozeLbl.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 30),
            snoozeLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),

            snoozeSubtitleLbl.topAnchor.constraint(equalTo: snoozeLbl.bottomAnchor),
            snoozeSubtitleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            snoozeSubtitleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),

            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            stackView.topAnchor.constraint(equalTo: snoozeSubtitleLbl.bottomAnchor, constant: 30),
            stackView.heightAnchor.constraint(equalToConstant: 73),

            nextBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            nextBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            nextBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            nextBtn.heightAnchor.constraint(equalToConstant: 69)
        ])


        [fiveMinuteBtn, tenMinuteBtn, fifteenMinBtn].forEach({stackView.addArrangedSubview($0)})

        stackView.spacing = 10
        stackView.distribution = .fillEqually

    }

    @objc func handleFiveBtnPressed() {
        snoozeTime = 5

        nextBtn.backgroundColor = UIColor(named: "YWROrange")
        nextBtn.isUserInteractionEnabled = true

        fiveMinuteBtn.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.4352941176, alpha: 1)
        fiveMinuteBtn.setTitleColor(#colorLiteral(red: 0.9843137255, green: 0.9764705882, blue: 0.9647058824, alpha: 1), for: .normal)

        tenMinuteBtn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        tenMinuteBtn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)

        fifteenMinBtn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        fifteenMinBtn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)
    }

    @objc func handleTenBtnPressed() {
        snoozeTime = 10

        nextBtn.backgroundColor = UIColor(named: "YWROrange")
        nextBtn.isUserInteractionEnabled = true

        fiveMinuteBtn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        fiveMinuteBtn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)

        tenMinuteBtn.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.4352941176, alpha: 1)
        tenMinuteBtn.setTitleColor(#colorLiteral(red: 0.9843137255, green: 0.9764705882, blue: 0.9647058824, alpha: 1), for: .normal)

        fifteenMinBtn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        fifteenMinBtn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)
    }

    @objc func handleFifteenBtnPressed() {
        snoozeTime = 15

        nextBtn.backgroundColor = UIColor(named: "YWROrange")
        nextBtn.isUserInteractionEnabled = true

        fiveMinuteBtn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        fiveMinuteBtn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)

        tenMinuteBtn.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        tenMinuteBtn.setTitleColor(#colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1), for: .normal)

        fifteenMinBtn.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.4352941176, alpha: 1)
        fifteenMinBtn.setTitleColor(#colorLiteral(red: 0.9843137255, green: 0.9764705882, blue: 0.9647058824, alpha: 1), for: .normal)
    }

    @objc func handleNextBtnPressed() {
        delegate?.didTapNext(alarmString: alarmString, snoozeTime: snoozeTime)
    }
}

extension SetAlarmView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return hourArray.count
        } else if component == 1 {
            return minuteArray.count
        } else {
            return amPMArray.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "ProximaNova-Bold", size: 60)
            pickerLabel?.textColor = UIColor(named: "YWROrange")
            pickerLabel?.textAlignment = .center
        }

        pickerLabel?.text = setupLabel(row: row, component: component)
        pickerLabel?.backgroundColor = #colorLiteral(red: 0.9752898812, green: 0.9653753638, blue: 0.9498916268, alpha: 1)
        return pickerLabel!
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 73
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hour = hourArray[pickerView.selectedRow(inComponent: 0)]
        let minute = minuteArray[pickerView.selectedRow(inComponent: 1)]
        let amPM = amPMArray[pickerView.selectedRow(inComponent: 2)]
        alarmString = hour + ":" + minute + amPM
    }

    func setupLabel(row: Int, component: Int) -> String {
        if component == 0 {
            return hourArray[row]
        } else if component == 1 {
            return minuteArray[row]
        } else {
            return amPMArray[row]
        }
    }
}

