//
//  AddMotivationView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import UIKit

enum ImageNumber {
    case one
    case two
    case three
    case four
}

protocol AddMotivationViewDelegate: AnyObject {
    func didTapNext()
    func didTapAddImage(imageNumber: ImageNumber)
}

class AddMotivationView: BaseView {
    weak var delegate: AddMotivationViewDelegate?

    let onboardingBar: OnboardingOrangeBar = {
        let v = OnboardingOrangeBar()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Add your motivation"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 28)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Choose up to four photos that will\nmotivate you to wake up."
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()


    lazy var imageView1: BaseMotivationImageView = {
        let imv = BaseMotivationImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.setupEmptyImageIcon()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImageView1))
        imv.addGestureRecognizer(tap)
        imv.isUserInteractionEnabled = true
        return imv
    }()

    lazy var imageView2: BaseMotivationImageView = {
        let imv = BaseMotivationImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.setupEmptyImageIcon()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImageView2))
        imv.addGestureRecognizer(tap)
        imv.isUserInteractionEnabled = true
        return imv
    }()

    lazy var imageView3: BaseMotivationImageView = {
        let imv = BaseMotivationImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.setupEmptyImageIcon()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImageView3))
        imv.addGestureRecognizer(tap)
        imv.isUserInteractionEnabled = true
        return imv
    }()

    lazy var imageView4: BaseMotivationImageView = {
        let imv = BaseMotivationImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.setupEmptyImageIcon()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImageView4))
        imv.addGestureRecognizer(tap)
        imv.isUserInteractionEnabled = true
        return imv
    }()

    let clickToAddPhotoLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 0.7)
        lbl.text = "Click to add a photo. Must add at least 1\nto continue."
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .center
        return lbl
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
         imageView1,
         imageView2,
         imageView3,
         imageView4,
         clickToAddPhotoLbl,
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

            imageView1.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 60),
            imageView1.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            imageView1.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            imageView1.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),

            imageView2.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 60),
            imageView2.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            imageView2.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            imageView2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),

            imageView3.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 16),
            imageView3.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            imageView3.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            imageView3.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),

            imageView4.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 16),
            imageView4.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            imageView4.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            imageView4.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),

            clickToAddPhotoLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            clickToAddPhotoLbl.topAnchor.constraint(equalTo: imageView3.bottomAnchor, constant: 23),
            clickToAddPhotoLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            clickToAddPhotoLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),

            nextBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            nextBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
        ])

        onboardingBar.setupBar(percentage: 0.99)
    }

    @objc func handleDidTapNext() {
        delegate?.didTapNext()
    }

    @objc func didTapImageView1(_ recognizer: UITapGestureRecognizer) {
        delegate?.didTapAddImage(imageNumber: .one)
    }

    @objc func didTapImageView2(_ recognizer: UITapGestureRecognizer) {
        delegate?.didTapAddImage(imageNumber: .two)
    }

    @objc func didTapImageView3(_ recognizer: UITapGestureRecognizer) {
        delegate?.didTapAddImage(imageNumber: .three)
    }

    @objc func didTapImageView4(_ recognizer: UITapGestureRecognizer) {
        delegate?.didTapAddImage(imageNumber: .four)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView1.layer.cornerRadius = 16
    }
}

