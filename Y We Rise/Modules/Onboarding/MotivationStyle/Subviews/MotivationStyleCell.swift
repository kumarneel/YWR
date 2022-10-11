//
//  MotivationStyleCell.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

enum MotivationStyle {
    case family
    case wealth
    case cars
    case love
    case career
    case kids
    case fame
    case health
    case winning
    case power
    case partner
    case fear
}

class MotivationStyleCell: UICollectionViewCell {

    static let ResuableIdentifier = "MotivationStyleCellId"

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.numberOfLines = 1
        lbl.textColor = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.4352941176, alpha: 1)
        return lbl
    }()

    func setupView() {
        layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        layer.borderWidth = 2
        layer.cornerRadius = 10

        addSubview(titleLbl)
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupStyle(style: MotivationStyle) {
        switch style {
        case .family:
            titleLbl.text = "👨‍👩‍👦‍👦Family"
        case .wealth:
            titleLbl.text = "💰Wealth"
        case .cars:
            titleLbl.text = "🚗Cars"
        case .love:
            titleLbl.text = "💖Love"
        case .career:
            titleLbl.text = "💼Career"
        case .kids:
            titleLbl.text = "👧Kids"
        case .fame:
            titleLbl.text = "📸Fame"
        case .health:
            titleLbl.text = "🌱Health"
        case .winning:
            titleLbl.text = "🏆Winning"
        case .power:
            titleLbl.text = "🛥Power"
        case .partner:
            titleLbl.text = "🫂Partner"
        case .fear:
            titleLbl.text = "😱Fear"
        }
    }
}


