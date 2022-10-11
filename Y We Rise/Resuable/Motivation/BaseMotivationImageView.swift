//
//  BaseMotivationImageView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import UIKit

class BaseMotivationImageView: UIImageView {

    let emptyIconImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "EmptyImageIcon")
        return imv
    }()

    func setupEmptyImageIcon() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        backgroundColor = #colorLiteral(red: 0.9752898812, green: 0.9653753638, blue: 0.9498916268, alpha: 1)
        addSubview(emptyIconImageView)

        NSLayoutConstraint.activate([
            emptyIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
