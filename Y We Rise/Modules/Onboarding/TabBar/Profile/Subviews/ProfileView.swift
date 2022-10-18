//
//  ProfileView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didTapEditSleepStyle()
    func didTapEditMotivationStyle()
}

class ProfileView: BaseView {

    weak var delegate: ProfileViewDelegate?

    var user: User? {
        didSet {
            guard let user = user else { return }
            nameTextField.text = user.name
            birthdayTextField.text = user.birthday.getBirthdayFromTimestamp()
            sleepStyleCollectionView.reloadData()
            motivationStyleCollectionView.reloadData()
        }
    }

    var scrollView: UIScrollView!

    let roundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        // TODO: need to fix the cornder radius to be correct
        v.layer.cornerRadius = (UIScreen.main.bounds.width / 4)
        return v
    }()

    let profileImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "ProfileImageIcon")
        return imv
    }()

    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1)
        lbl.text = "Name"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(named: "YWRCreamDarkened")
        tf.layer.cornerRadius = 15
        tf.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        tf.placeholder = "Name"
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.layer.borderWidth = 3
        tf.layer.borderColor = UIColor.clear.cgColor
        tf.clearButtonMode = .whileEditing
        return tf
    }()

    let dateOfBirthLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1)
        lbl.text = "Date Of Birth"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()

    let birthdayTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(named: "YWRCreamDarkened")
        tf.layer.cornerRadius = 15
        tf.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        tf.placeholder = "10/22/2000"
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.layer.borderWidth = 3
        tf.layer.borderColor = UIColor.clear.cgColor
        tf.clearButtonMode = .whileEditing
        return tf
    }()

    let sleepPreferencesLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1)
        lbl.text = "Sleep Preferences"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()

    lazy var sleepStyleEditIconImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "EditIcon")
        imv.isUserInteractionEnabled = true
        imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEditSleepStyleIconTapped)))
        return imv
    }()

    lazy var sleepStyleCollectionView: UICollectionView = {
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

    let motiviationPreferencesLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.8214116693, green: 0.8003239036, blue: 0.7640663385, alpha: 1)
        lbl.text = "Motivation Preferences"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()

    lazy var motivationStyleIconImageView: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "EditIcon")
        imv.isUserInteractionEnabled = true
        imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEditMovitionIconTapped)))
        return imv
    }()

    lazy var motivationStyleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
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

    var datePicker = UIDatePicker()
    
    override func setupView() {
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        backgroundColor = UIColor(named: "YWROrange")!

        addSubview(scrollView)

        [roundView,
         profileImageView,
         nameLbl,
         nameTextField,
         dateOfBirthLbl,
         birthdayTextField,
         sleepPreferencesLbl,
         sleepStyleEditIconImageView,
         sleepStyleCollectionView,
         motiviationPreferencesLbl,
         motivationStyleIconImageView,
         motivationStyleCollectionView
        ].forEach({scrollView.addSubview($0)})

        NSLayoutConstraint.activate([
            roundView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80),
            roundView.rightAnchor.constraint(equalTo: rightAnchor),
            roundView.heightAnchor.constraint(equalToConstant: 1700),
            roundView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),

            profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            nameLbl.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 33),
            nameLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 34),

            nameTextField.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 13),
            nameTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 34),
            nameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -34),
            nameTextField.heightAnchor.constraint(equalToConstant: 58),

            dateOfBirthLbl.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 26),
            dateOfBirthLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 34),

            birthdayTextField.topAnchor.constraint(equalTo: dateOfBirthLbl.bottomAnchor, constant: 13),
            birthdayTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 34),
            birthdayTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -34),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 58),

            sleepPreferencesLbl.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 26),
            sleepPreferencesLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 34),

            sleepStyleEditIconImageView.topAnchor.constraint(equalTo: sleepPreferencesLbl.topAnchor),
            sleepStyleEditIconImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -34),

            sleepStyleCollectionView.topAnchor.constraint(equalTo: sleepPreferencesLbl.bottomAnchor, constant: 30),
            sleepStyleCollectionView.heightAnchor.constraint(equalToConstant: 385),
            sleepStyleCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            sleepStyleCollectionView.rightAnchor.constraint(equalTo: rightAnchor),

            motiviationPreferencesLbl.topAnchor.constraint(equalTo: sleepStyleCollectionView.bottomAnchor, constant: 26),
            motiviationPreferencesLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 34),

            motivationStyleIconImageView.topAnchor.constraint(equalTo: motiviationPreferencesLbl.topAnchor),
            motivationStyleIconImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -34),

            motivationStyleCollectionView.topAnchor.constraint(equalTo: motiviationPreferencesLbl.bottomAnchor, constant: 30),
            motivationStyleCollectionView.heightAnchor.constraint(equalToConstant: 350),
            motivationStyleCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            motivationStyleCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
        ])

        scrollView.contentSize = CGSize(width: screenWidth, height: 1250)

        setupDatePicker()

        addActivityView()
    }

    @objc func handleTextChange(_ textField: UITextField) {
        if textField == nameTextField {

        } else if textField == birthdayTextField {

        }
    }

    func setupDatePicker() {
        // setting up date picker...
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        birthdayTextField.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let date = dateFormatter.date(from: "17:00") {
            datePicker.date = date
        }
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()

        birthdayTextField.inputView = datePicker
    }

    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        birthdayTextField.text = formatter.string(from: datePicker.date)
        formatter.dateFormat = "MM-dd-yyyy"
        birthdayTextField.layer.borderWidth = 0
        self.endEditing(true)
        // TODO: Save new date to firebase
//        delegate?.didTapDone(date: datePicker.date)
    }

    @objc func cancelDatePicker(){
        self.endEditing(true)
    }

    @objc func handleEditMovitionIconTapped() {
        delegate?.didTapEditMotivationStyle()
    }

    @objc func handleEditSleepStyleIconTapped() {
        delegate?.didTapEditSleepStyle()
    }
}

extension ProfileView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let user = user else { return 0 }
        if collectionView == sleepStyleCollectionView {
            return user.sleep_styles.count
        } else {
            return user.motivation_styles.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let user = user else { return UICollectionViewCell() }
        if collectionView == sleepStyleCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SleepStyleCell.ResuableIdentifier, for: indexPath) as? SleepStyleCell else { return UICollectionViewCell() }
            cell.setupView()
            var style: SleepStyle = .nightOwl
            style = style.getCorrectStyle(name: user.sleep_styles[indexPath.item])

            cell.setupStyle(sleepStyle: style)
            cell.setupCellBorder()
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MotivationStyleCell.ResuableIdentifier, for: indexPath) as? MotivationStyleCell else { return UICollectionViewCell() }
            cell.setupView()
            var style: MotivationStyle = .fear
            style = style.getCorrectMotivation(name: user.motivation_styles[indexPath.item])
            cell.setupStyle(style: style)
            cell.isUserInteractionEnabled = false
            cell.handleCellTapped()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sleepStyleCollectionView {
            return CGSize(width: 293, height: 380)
        } else {
            return CGSize(width: 98, height: 42)
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sleepStyleCollectionView {
            return 20
        } else {
            return 0
        }
    }
}
