//
//  OnboardingOrangeBar.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

class OnboardingOrangeBar: BaseView {

    let backgroundBarView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "YWRCreamDarkened")
        return v
    }()

    let fillBarView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "YWROrange")
        v.layer.cornerRadius = 3
        return v
    }()

    func setupBar(percentage: Double) {
        layer.cornerRadius = 3

        [backgroundBarView, fillBarView].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            backgroundBarView.topAnchor.constraint(equalTo: topAnchor),
            backgroundBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundBarView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundBarView.rightAnchor.constraint(equalTo: rightAnchor),

            fillBarView.topAnchor.constraint(equalTo: topAnchor),
            fillBarView.leftAnchor.constraint(equalTo: leftAnchor),
            fillBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            fillBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: CGFloat(percentage))
        ])
    }
}
