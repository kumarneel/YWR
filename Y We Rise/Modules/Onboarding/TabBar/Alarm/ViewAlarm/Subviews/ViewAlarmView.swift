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
            if alarm.images.count == 1 {
                stopAlarmBtn.backgroundColor = UIColor(named: "YWROrange")
                stopAlarmBtn.isUserInteractionEnabled = true
            }
            pageControl.numberOfPages = alarm.images.count
        }
    }
    
    let timerBackgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9568627451, blue: 0.937254902, alpha: 1)
        v.layer.cornerRadius = 8
        return v
    }()
    
    let timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 55)
        return lbl
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
        btn.isUserInteractionEnabled = false
        btn.isHidden = false
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
        cv.isUserInteractionEnabled = false
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        pc.currentPageIndicatorTintColor = .white
        pc.backgroundColor = .clear
        return pc
    }()
    
    var timer = Timer()
    var counter = 10
    var page = 0

    override func setupView() {
        backgroundColor = UIColor(named: "YWRCream")


        [timerBackgroundView, timerLabel, snoozeBtn, stopAlarmBtn, collectionView, pageControl].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            timerBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 82),
            timerBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerBackgroundView.heightAnchor.constraint(equalToConstant: 66),
            timerBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            timerBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            
            timerLabel.centerXAnchor.constraint(equalTo: timerBackgroundView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerBackgroundView.centerYAnchor),

            snoozeBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -52),
            snoozeBtn.centerXAnchor.constraint(equalTo: centerXAnchor),

            stopAlarmBtn.bottomAnchor.constraint(equalTo: snoozeBtn.topAnchor, constant: -33),
            stopAlarmBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 17),
            stopAlarmBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -17),
            stopAlarmBtn.heightAnchor.constraint(equalToConstant: 69),

            collectionView.topAnchor.constraint(equalTo: timerBackgroundView.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: stopAlarmBtn.topAnchor, constant: -30),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -10),
            
        ])
        
        startTimer()
    }
    
    func startTimer() {
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        counter -= 1
        let s = String(format: "%02d", counter)
        if counter > 0 {
            let string = "00:00:" + s
            let aT = NSMutableAttributedString(string: string, attributes: [NSMutableAttributedString.Key.font: UIFont(name: "ProximaNova-Bold", size: 55) as Any])
            let firstRange = NSRange(location: 0, length: 6)
            aT.addAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)], range: firstRange)
            let secondRange = NSRange(location: 6, length: 2)
            aT.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "YWROrange")!], range: secondRange)
            timerLabel.attributedText = aT
        } else {
            page += 1
            /// invalidate timer on last photo
            if page == alarm?.images.count {
                invalidateTimer()
            } else {
                /// go to next photo
                timer.invalidate()
                startTimer()
                scrollToNextCell()
            }
        }
    }

    @objc func handleStopBtnPressed() {
        guard let alarm = alarm else { return }
        delegate?.didTapStop(alarm: alarm)
    }

    @objc func handleSnoozeBtnPressed() {
        guard let alarm = alarm else { return }
        delegate?.didTapSnooze(alarm: alarm)
    }
    
    func enableButtons() {
        stopAlarmBtn.backgroundColor = UIColor(named: "YWROrange")
        stopAlarmBtn.isUserInteractionEnabled = true
        snoozeBtn.setTitleColor(UIColor(named: "YWROrange"), for: .normal)
        snoozeBtn.isUserInteractionEnabled = true
    }
    
    func invalidateTimer() {
        timer.invalidate()
        timerLabel.text = "00:00:00"
        timerLabel.textColor = UIColor(named: "YWROrange")
        enableButtons()
    }
    
    func scrollToNextCell(){
        let cellSize = CGSizeMake(collectionView.frame.width, collectionView.frame.height)
        let contentOffset = collectionView.contentOffset
        collectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true);
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
        cell.contentMode = .scaleAspectFill
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }

}
