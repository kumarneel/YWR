//
//  EnterBirthdayView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

protocol EnterBirthdayViewDelegate: AnyObject {
    func didTapDone(date: Date)
}

class EnterBirthdayView: BaseView {

    weak var delegate: EnterBirthdayViewDelegate?

    let onboardingBar: OnboardingOrangeBar = {
        let v = OnboardingOrangeBar()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "When's your birthday?"
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.font = UIFont(name: "ProximaNova-Bold", size: 28)
        return lbl
    }()

    let subtitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "We use this to show your age."
        lbl.textColor = UIColor(named: "YWRCreamText")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lbl.numberOfLines = 2
        return lbl
    }()

    let birthdayTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(named: "YWRCreamDarkened")
        tf.layer.cornerRadius = 15
        tf.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        tf.placeholder = "10/04/1990"
        tf.textAlignment = .center
        return tf
    }()

    var datePicker = UIDatePicker()

    override func setupView() {

        backgroundColor = UIColor(named: "YWRCream")!

        [onboardingBar, titleLbl, subtitleLbl, birthdayTextField].forEach({addSubview($0)})

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

            birthdayTextField.topAnchor.constraint(equalTo: subtitleLbl.bottomAnchor, constant: 65),
            birthdayTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            birthdayTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 65)
        ])

        setupDatePicker()
        onboardingBar.setupBar(percentage: 0.285)

        addActivityView()
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
        //        userBirthdayString = formatter.string(from: datePicker.date)
        birthdayTextField.layer.borderWidth = 0
        self.endEditing(true)
        delegate?.didTapDone(date: datePicker.date)
    }

    @objc func cancelDatePicker(){
        self.endEditing(true)
    }
}
