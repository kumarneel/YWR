//
//  SleepDescriptionView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

enum SleepStyle {
    case nightOwl
    case earlyBird
    case wakerUpper
}

protocol SleepStyleCellDelegate: AnyObject {
    func didTapCell(sleepStyle: SleepStyle, selected: Bool)
}

class SleepStyleCell: UICollectionViewCell {

    static let ResuableIdentifier = "SleepStyleCellId"

    weak var delegate: SleepStyleCellDelegate?

    var sleepStyle: SleepStyle = .nightOwl

    var cellSelected = false

    let backgroundImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
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
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCellTapped)))
    }

    func setupStyle(sleepStyle: SleepStyle) {
        self.sleepStyle = sleepStyle
        switch sleepStyle {
        case .nightOwl:
            backgroundImageView.image = UIImage(named: "NightOwlIcon")
            backgroundImageView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9490196078, blue: 1, alpha: 1)
            titleLbl.text = "Night Owl"
            subtitleLbl.text = "“I usually fall asleep\nafter midnight”"
        case .earlyBird:
            backgroundImageView.image = UIImage(named: "EarlyBirdIcon")
            backgroundImageView.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0.8078431373, alpha: 1)
            titleLbl.text = "Early Bird"
            subtitleLbl.text = "“I wake up really early,\nusually before 6am”"
        case .wakerUpper:
            backgroundImageView.image = UIImage(named: "WakerUpperIcon")
            backgroundImageView.backgroundColor = #colorLiteral(red: 1, green: 0.9568627451, blue: 0.8078431373, alpha: 1)
            titleLbl.text = "Waker Upper"
            subtitleLbl.text = "“I usually wake up 3 or 4\ntimes a night”"
        }
    }

    @objc func handleCellTapped() {
        if cellSelected {
            layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            cellSelected = false
            delegate?.didTapCell(sleepStyle: sleepStyle, selected: cellSelected)
        } else {
            layer.borderColor = UIColor(named: "YWROrange")!.cgColor
            cellSelected = true
            delegate?.didTapCell(sleepStyle: sleepStyle, selected: cellSelected)
        }
    }

    func setupCellBorder() {
        if cellSelected {
            layer.borderColor = UIColor(named: "YWROrange")!.cgColor
        } else {
            layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        }
    }
}
