//
//  MotivationStyleCell.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

enum MotivationStyle: String {
    case family = "family"
    case wealth = "wealth"
    case cars = "cars"
    case love = "love"
    case career = "careers"
    case kids = "kids"
    case fame = "fame"
    case health = "health"
    case winning = "winning"
    case power = "power"
    case partner = "partner"
    case fear = "fear"
}

protocol MotivationStyleCellDelegate: AnyObject {
    func didTapCell(motivationStyle: MotivationStyle, selected: Bool)
}

class MotivationStyleCell: UICollectionViewCell {

    weak var delegate: MotivationStyleCellDelegate?

    static let ResuableIdentifier = "MotivationStyleCellId"

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.numberOfLines = 1
        lbl.textColor = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.4352941176, alpha: 1)
        return lbl
    }()

    var motivationStyle: MotivationStyle = .health
    var cellSelected = false

    func setupView() {
        layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        layer.borderWidth = 2
        layer.cornerRadius = 10

        addSubview(titleLbl)
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCellTapped)))
    }

    func setupStyle(style: MotivationStyle) {
        self.motivationStyle = style
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

    @objc func handleCellTapped() {
        if cellSelected {
            backgroundColor = .clear
            layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            titleLbl.textColor = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.4352941176, alpha: 1 )
            cellSelected = false
            delegate?.didTapCell(motivationStyle: motivationStyle, selected: cellSelected)
        } else {
            titleLbl.textColor = #colorLiteral(red: 0.9752898812, green: 0.9653753638, blue: 0.9498916268, alpha: 1)
            backgroundColor = UIColor(named: "YWROrange")
            cellSelected = true
            delegate?.didTapCell(motivationStyle: motivationStyle, selected: cellSelected)
        }
    }
}


