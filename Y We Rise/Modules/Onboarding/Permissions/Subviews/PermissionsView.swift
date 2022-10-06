//
//  PermissionsView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

protocol PermissionsViewDelegate: AnyObject {
    func didTapNext()
    func didTapSwitch()
}

class PermissionsView: BaseView {

    weak var delegate: PermissionsViewDelegate?

    let onboardingBar: OnboardingOrangeBar = {
        let v = OnboardingOrangeBar()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Can we send you\nNotifications?"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 28)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is used to wake you up."
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()

    let alarmSoundsTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Alarm Sounds"
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 24)
        return lbl
    }()

    let alarmSoundsSubtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "This is how we will\nwake you up!"
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()

    let notificationSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        return sw
    }()

    lazy var notNowBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleDidTapNext), for: .touchUpInside)
        btn.setTitle("not now", for: .normal)
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

    override func setupView() {

        backgroundColor = UIColor(named: "YWRCream")!

        [onboardingBar,
         titleLbl,
         subtitleLbl,
         alarmSoundsTitleLbl,
         alarmSoundsSubtitleLbl,
         notificationSwitch,
         notNowBtn,
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

            alarmSoundsTitleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            alarmSoundsTitleLbl.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 84),

            alarmSoundsSubtitleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            alarmSoundsSubtitleLbl.topAnchor.constraint(equalTo: alarmSoundsTitleLbl.bottomAnchor),

            notificationSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            notificationSwitch.topAnchor.constraint(equalTo: alarmSoundsTitleLbl.topAnchor),
            notificationSwitch.heightAnchor.constraint(equalToConstant: 38),
            notificationSwitch.widthAnchor.constraint(equalToConstant: 74),

            notNowBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            notNowBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),

            nextBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            nextBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
        ])

        onboardingBar.setupBar(percentage: 0.4275)
    }

    @objc func switchValueDidChange(_ sender: UISwitch) {
        nextBtn.setImage(UIImage(named: "SendCodeBtnFilled"), for: .normal)
        nextBtn.isUserInteractionEnabled = true
        delegate?.didTapSwitch()
    }

    @objc func handleDidTapNext() {
        delegate?.didTapNext()
    }
}
