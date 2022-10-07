//
//  SleepDescriptionView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

class SleepStyleCell: UICollectionViewCell {

    enum SleepStyle {
        case nightOwl
        case earlyBird
        case wakerUpper
    }

    static let ResuableIdentifier = "SleepStyleCellId"

    let backgroundImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "NightOwlIcon")
        return imv
    }()

    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Night Owl"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 24)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "“I usually fall asleep\nafter midnight”"
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()

    func setupView() {
        layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        layer.borderWidth = 2
        layer.cornerRadius = 15

        [backgroundImageView, titleLbl, subtitleLbl].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 235),

            titleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 22),
            titleLbl.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 25),

            subtitleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 22),
            subtitleLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor)
        ])
    }

    func setupStyle(sleepStyle: SleepStyle) {
        switch sleepStyle {
        case .nightOwl:
            titleLbl.text = "Night Owl"
            subtitleLbl.text = "“I usually fall asleep\nafter midnight”"
        case .earlyBird:
            titleLbl.text = "Early Bird"
            subtitleLbl.text = "“I wake up really early,\nusually before 6am”"
        case .wakerUpper:
            titleLbl.text = "Waker Upper"
            subtitleLbl.text = "“I usually wake up 3 or 4\ntimes a night”"
        }
    }
}
