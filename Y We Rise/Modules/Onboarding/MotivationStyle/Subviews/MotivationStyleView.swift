//
//  MotivationStyleView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

class MotivationStyleView: BaseView {

    let onboardingBar: OnboardingOrangeBar = {
        let v = OnboardingOrangeBar()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "What motivates you?"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 28)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Pick at least two categories\nthat motivate you."
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 2
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

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        cv.register(MotivationStyleCell.self, forCellWithReuseIdentifier: MotivationStyleCell.ResuableIdentifier)
        cv.keyboardDismissMode = .none
        cv.backgroundColor = .clear
        return cv
    }()

    override func setupView() {

        backgroundColor = UIColor(named: "YWRCream")!

        [onboardingBar,
         titleLbl,
         subtitleLbl,
         collectionView,
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

            collectionView.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 40),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
            collectionView.heightAnchor.constraint(equalToConstant: 350),

            nextBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            nextBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
        ])

        onboardingBar.setupBar(percentage: 0.7125)
    }

    @objc func handleDidTapNext() {

    }
}

extension MotivationStyleView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MotivationStyleCell.ResuableIdentifier, for: indexPath) as? MotivationStyleCell else { return UICollectionViewCell() }
        cell.setupView()
        if indexPath.row == 0 {
            cell.setupStyle(style: .family)
        }else if indexPath.row == 1 {
            cell.setupStyle(style: .wealth)
        }else if indexPath.row == 2 {
            cell.setupStyle(style: .cars)
        }else if indexPath.row == 3 {
            cell.setupStyle(style: .love)
        }else if indexPath.row == 4 {
            cell.setupStyle(style: .career)
        }else if indexPath.row == 5 {
            cell.setupStyle(style: .kids)
        }else if indexPath.row == 6 {
            cell.setupStyle(style: .fame)
        }else if indexPath.row == 7 {
            cell.setupStyle(style: .health)
        }else if indexPath.row == 8 {
            cell.setupStyle(style: .winning)
        }else if indexPath.row == 9 {
            cell.setupStyle(style: .power)
        }else if indexPath.row == 10 {
            cell.setupStyle(style: .partner)
        }else if indexPath.row == 11 {
            cell.setupStyle(style: .fear)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: add dynamic cells to text ask trent if we really need this
        return CGSize(width: 98, height: 42)
    }
}
