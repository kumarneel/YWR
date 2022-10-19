//
//  SleepStyleView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

protocol SleepStyleViewDelegate: AnyObject {
    func didTapNext()
    func didTapStyle(sleepStyle: SleepStyle, selected: Bool)
    func didTapSave()
}

class SleepStyleView: BaseView {

    var isEditing: Bool? {
        didSet {
            guard let isEditing = isEditing else { return }
            onboardingBar.isHidden = isEditing
            nextBtn.isHidden = isEditing
            saveChangesBtn.isHidden = !isEditing

            if isEditing {
                titleLbl.text = "Sleep Preferences"
                subtitleLbl.text = "Pick the sleep type that best\nrepresents you. These will be used\nin later YWR updates."
            }
        }
    }

    var sleepStyles: [String]?

    weak var delegate: SleepStyleViewDelegate?

    let onboardingBar: OnboardingOrangeBar = {
        let v = OnboardingOrangeBar()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "How would you\ndescribe your sleep?"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 28)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Pick the one that most describes\nyour average sleep habits."
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 3
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        cv.register(SleepStyleCell.self, forCellWithReuseIdentifier: SleepStyleCell.ResuableIdentifier)
        cv.keyboardDismissMode = .none
        cv.backgroundColor = .clear
        return cv
    }()

    lazy var saveChangesBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Save Changes", for: .normal)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 24)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = UIColor(named: "YWROrange")
        btn.setTitleColor(#colorLiteral(red: 0.9877046943, green: 0.981163919, blue: 0.9719136357, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(handleSaveChangesBtnPressed), for: .touchUpInside)
        return btn
    }()

    override func setupView() {
        backgroundColor = UIColor(named: "YWRCream")!

        [onboardingBar,
         titleLbl,
         subtitleLbl,
         collectionView,
         saveChangesBtn,
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

            collectionView.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 30),
            collectionView.heightAnchor.constraint(equalToConstant: 385),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),

            saveChangesBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -54),
            saveChangesBtn.heightAnchor.constraint(equalToConstant: 69),
            saveChangesBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            saveChangesBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),

            nextBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            nextBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),

        ])

        onboardingBar.setupBar(percentage: 0.57)

        addActivityView()
    }

    @objc func handleDidTapNext() {
        delegate?.didTapNext()
    }

    @objc func handleSaveChangesBtnPressed() {
        delegate?.didTapSave()
    }
}

extension SleepStyleView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SleepStyleCell.ResuableIdentifier, for: indexPath) as? SleepStyleCell else { return UICollectionViewCell() }
        cell.setupView()
        cell.delegate = self
        if indexPath.item == 0 {
            cell.setupStyle(sleepStyle: .nightOwl)
        } else if indexPath.item == 1 {
            cell.setupStyle(sleepStyle: .earlyBird)
        } else if indexPath.item == 2 {
            cell.setupStyle(sleepStyle: .wakerUpper)
        }
        cell.setupCellBorder()

        if isSleepStyleAlreadySelected(style: cell.sleepStyle) {
            cell.handleCellTapped()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 293, height: 380)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension SleepStyleView: SleepStyleCellDelegate {
    func didTapCell(sleepStyle: SleepStyle, selected: Bool) {
        nextBtn.setImage(UIImage(named: "SendCodeBtnFilled"), for: .normal)
        nextBtn.isUserInteractionEnabled = true
        delegate?.didTapStyle(sleepStyle: sleepStyle, selected: selected)
    }
}

extension SleepStyleView {
    func isSleepStyleAlreadySelected(style: SleepStyle) -> Bool {
        guard let sleepStyles = sleepStyles else { return false }

        for styleString in sleepStyles {
            var alreadySelectedStyle: SleepStyle = .nightOwl
            alreadySelectedStyle = alreadySelectedStyle.getCorrectStyle(name: styleString)
            if style == alreadySelectedStyle {
                return true
            }
        }
        return false
    }
}
