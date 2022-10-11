//
//  FirstAlarmView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/7/22.
//

import UIKit

class FirstAlarmView: BaseView {

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
        btn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
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
            return 12
        } else if component == 1 {
            return 60
        } else {
            return 2
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

    func setupLabel(row: Int, component: Int) -> String {
        if component == 0 {
            return "\(row + 1)"
        } else if component == 1 {
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)"
            }
        } else {
            if row == 0 {
                return "AM"
            } else {
                return "PM"
            }
        }

    }
}
