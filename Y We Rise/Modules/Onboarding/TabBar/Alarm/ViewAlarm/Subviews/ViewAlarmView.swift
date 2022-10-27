//
//  ViewAlarmView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/26/22.
//

import UIKit

protocol ViewAlarmViewDelegate: AnyObject {
    func didTapSnooze(alarm: Alarm)
    func didTapStop(alarm: Alarm)
}

class ViewAlarmView: BaseView {

    weak var delegate: ViewAlarmViewDelegate?

    var alarm: Alarm? {
        didSet {
            guard let alarm = alarm else { return }
            collectionView.reloadData()
        }
    }

    let YWRLogo: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "YWRLogoIcon")
        return imv
    }()

    lazy var stopAlarmBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.4666666667, blue: 0, alpha: 0.12)
        btn.setTitle("Stop", for: .normal)
        btn.addTarget(self, action: #selector(handleStopBtnPressed), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 24)
        btn.setTitleColor(#colorLiteral(red: 0.9843137255, green: 0.9764705882, blue: 0.9647058824, alpha: 1), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()

    lazy var snoozeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Snooze", for: .normal)
        btn.addTarget(self, action: #selector(handleSnoozeBtnPressed), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 24)
        btn.setTitleColor(#colorLiteral(red: 0.7803921569, green: 0.7568627451, blue: 0.7137254902, alpha: 1), for: .normal)
        btn.isUserInteractionEnabled = true
        return btn
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        cv.register(ViewMotivationPhotoCell.self, forCellWithReuseIdentifier: ViewMotivationPhotoCell.ResuableIdentifier)
        cv.keyboardDismissMode = .none
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        return cv
    }()

    override func setupView() {
        backgroundColor = UIColor(named: "YWRCream")


        [YWRLogo, snoozeBtn, stopAlarmBtn, collectionView].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            YWRLogo.topAnchor.constraint(equalTo: topAnchor, constant: 82),
            YWRLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            YWRLogo.heightAnchor.constraint(equalToConstant: 22),
            YWRLogo.widthAnchor.constraint(equalToConstant: 140),

            snoozeBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -52),
            snoozeBtn.centerXAnchor.constraint(equalTo: centerXAnchor),

            stopAlarmBtn.bottomAnchor.constraint(equalTo: snoozeBtn.topAnchor, constant: -33),
            stopAlarmBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            stopAlarmBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            stopAlarmBtn.heightAnchor.constraint(equalToConstant: 69),

            collectionView.topAnchor.constraint(equalTo: YWRLogo.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: stopAlarmBtn.topAnchor, constant: -30),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])

    }

    @objc func handleStopBtnPressed() {
        guard let alarm = alarm else { return }
        delegate?.didTapStop(alarm: alarm)
    }

    @objc func handleSnoozeBtnPressed() {
        guard let alarm = alarm else { return }
        delegate?.didTapSnooze(alarm: alarm)
    }
}
extension ViewAlarmView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let alarm = alarm else { return 0 }
        return alarm.images.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let alarm = alarm else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewMotivationPhotoCell.ResuableIdentifier, for: indexPath) as? ViewMotivationPhotoCell else { return UICollectionViewCell() }
        cell.setupView()
        cell.imageView.image = alarm.images[indexPath.row]
        cell.contentMode = .scaleAspectFit
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }

        guard let alarm = alarm else { return }
        if indexPath.row == alarm.images.count-1 {
            stopAlarmBtn.backgroundColor = UIColor(named: "YWROrange")
            stopAlarmBtn.isUserInteractionEnabled = true
        }
    }
}
