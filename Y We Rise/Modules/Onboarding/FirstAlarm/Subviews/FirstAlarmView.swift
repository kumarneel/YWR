//
//  FirstAlarmView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/7/22.
//

import UIKit

protocol FirstAlarmViewDelegate: AnyObject {
    func didTapNext(alarmString: String)
    func didTapSkip()
}

class FirstAlarmView: BaseView {

    var hourArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]

    var minuteArray = [
        "00",
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25",
        "26",
        "27",
        "28",
        "29",
        "30",
        "31",
        "32",
        "33",
        "34",
        "35",
        "36",
        "37",
        "38",
        "39",
        "40",
        "41",
        "42",
        "43",
        "44",
        "45",
        "46",
        "47",
        "48",
        "49",
        "50",
        "51",
        "52",
        "53",
        "54",
        "55",
        "56",
        "57",
        "58",
        "59"]

    var amPMArray = ["AM", "PM"]

    weak var delegate: FirstAlarmViewDelegate?

    let onboardingBar: OnboardingOrangeBar = {
        let v = OnboardingOrangeBar()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Set your first alarm"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 28)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Choose what time you want to be\nwoken up every day."
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()

    lazy var skipBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleDidTapSkip), for: .touchUpInside)
        btn.setTitle("Skip", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        btn.setTitleColor(#colorLiteral(red: 0.7803921569, green: 0.7568627451, blue: 0.7137254902, alpha: 1), for: .normal)
        return btn
    }()

    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleDidTapNext), for: .touchUpInside)
        btn.setImage(UIImage(named: "SendCodeBtnFilled"), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()

    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()

    var alarmString = "1:00AM"

    override func setupView() {

        backgroundColor = UIColor(named: "YWRCream")!

        [onboardingBar,
         titleLbl,
         subtitleLbl,
         pickerView,
         skipBtn,
         nextBtn].forEach({addSubview($0)})

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

            pickerView.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 50),
            pickerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            pickerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            pickerView.heightAnchor.constraint(equalToConstant: 220),

            skipBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            skipBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),

            nextBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            nextBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
        ])

        onboardingBar.setupBar(percentage: 0.855)
    }

    @objc func handleDidTapSkip() {
        delegate?.didTapSkip()
    }

    @objc func handleDidTapNext() {
        
    }
}

extension FirstAlarmView: UIPickerViewDelegate, UIPickerViewDataSource {
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
        print(alarmString)
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
