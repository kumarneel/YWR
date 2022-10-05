//
//  GetStartView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

protocol GetStartedViewDelegate: AnyObject {
    func didTapGetStartedBtn()
}

class GetStartedView: BaseView {

    weak var delegate: GetStartedViewDelegate?
    
    let backgroundImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "GetStartedBackgroundIcon")
        return imv
    }()

    let YWRLogo: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "YWRLogoIcon")
        return imv
    }()

    lazy var getStartedBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(named: "YWROrange")!
        btn.setTitle("Get Started", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 24)
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(handleGetStartedBtnPressed), for: .touchUpInside)
        return btn
    }()

    override func setupView() {
        
        [backgroundImageView, YWRLogo, getStartedBtn].forEach({addSubview($0)})

        NSLayoutConstraint.activate([
            backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            YWRLogo.topAnchor.constraint(equalTo: topAnchor, constant: 175),
            YWRLogo.centerXAnchor.constraint(equalTo: centerXAnchor),

            getStartedBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            getStartedBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -94),
            getStartedBtn.heightAnchor.constraint(equalToConstant: 75),
            getStartedBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            getStartedBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
        ])
    }

    @objc func handleGetStartedBtnPressed() {
        delegate?.didTapGetStartedBtn()
    }
}
