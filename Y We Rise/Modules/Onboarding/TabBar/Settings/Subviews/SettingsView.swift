//
//  SettingsView.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit
import StoreKit

protocol SettingsViewDelegate: AnyObject {
    func didTapLogout()
    func didTapDeleteAccount()
    func didTapReachOut()
}

class SettingsView: BaseView {

    weak var delegate: SettingsViewDelegate?

    var scrollView: UIScrollView!

    let YWRLogo: UIImageView = {
        let imv = UIImageView()
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "YWRLogoIcon")
        return imv
    }()

    lazy var reviewUsBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Review Us", for: .normal)
        btn.setTitleColor(UIColor(named: "YWRBlue"), for: .normal)
        btn.setImage(UIImage(named: "YWRReviewUsIcon"), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9752898812, green: 0.9653753638, blue: 0.9498916268, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets.left = 25
        btn.titleEdgeInsets.left = 45
        btn.isUserInteractionEnabled = true
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 20)
        btn.addTarget(self, action: #selector(handleReviewUsBtn), for: .touchUpInside)
        return btn
    }()

    lazy var termsAndConditionsBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Terms & Conditions", for: .normal)
        btn.setTitleColor(UIColor(named: "YWRBlue"), for: .normal)
        btn.setImage(UIImage(named: "YWRTandCIcon"), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9752898812, green: 0.9653753638, blue: 0.9498916268, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets.left = 25
        btn.titleEdgeInsets.left = 45
        btn.isUserInteractionEnabled = true
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 20)
        btn.addTarget(self, action: #selector(handleTermsAndConditionsBtnPressed), for: .touchUpInside)
        return btn
    }()

    lazy var privacyPolicyBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Privacy Policy", for: .normal)
        btn.setTitleColor(UIColor(named: "YWRBlue"), for: .normal)
        btn.setImage(UIImage(named: "YWRPrivacyPolicyIcon"), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9752898812, green: 0.9653753638, blue: 0.9498916268, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets.left = 25
        btn.titleEdgeInsets.left = 45
        btn.isUserInteractionEnabled = true
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 20)
        btn.addTarget(self, action: #selector(handlePrivacyPolicyBtnPressed), for: .touchUpInside)
        return btn
    }()

    lazy var reachOutBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Reach Out To Us", for: .normal)
        btn.setTitleColor(UIColor(named: "YWRBlue"), for: .normal)
        btn.setImage(UIImage(named: "YWRReachOutToUsIcon"), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9752898812, green: 0.9653753638, blue: 0.9498916268, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets.left = 25
        btn.titleEdgeInsets.left = 45
        btn.isUserInteractionEnabled = true
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 20)
        btn.addTarget(self, action: #selector(handleReachOutBtnPressed), for: .touchUpInside)
        return btn
    }()

    lazy var logoutBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Log Out", for: .normal)
        btn.setTitleColor(UIColor(named: "YWRBlue"), for: .normal)
        btn.setImage(UIImage(named: "YWRLogOutIcon"), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9752898812, green: 0.9653753638, blue: 0.9498916268, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.contentHorizontalAlignment = .left
        btn.imageEdgeInsets.left = 25
        btn.titleEdgeInsets.left = 45
        btn.isUserInteractionEnabled = true
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 20)
        btn.addTarget(self, action: #selector(handleLogoutBtn), for: .touchUpInside)
        return btn
    }()

    lazy var deleteAccountBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("DELETE ACCOUNT", for: .normal)
        btn.setTitleColor(UIColor(named: "YWRBlue"), for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 15
        btn.isUserInteractionEnabled = true
        btn.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 20)
        btn.addTarget(self, action: #selector(handleDeleteAccountBtn), for: .touchUpInside)
        return btn
    }()

    override func setupView() {
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.backgroundColor = UIColor(named: "YWRCream")!


        [YWRLogo,
         reviewUsBtn,
         termsAndConditionsBtn,
         privacyPolicyBtn,
         reachOutBtn,
         logoutBtn,
         deleteAccountBtn].forEach({scrollView.addSubview($0)})

        addSubview(scrollView)

        NSLayoutConstraint.activate([

            YWRLogo.topAnchor.constraint(equalTo: scrollView.topAnchor),
            YWRLogo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            YWRLogo.heightAnchor.constraint(equalToConstant: 21),
            YWRLogo.widthAnchor.constraint(equalToConstant: 120),

            reviewUsBtn.topAnchor.constraint(equalTo: YWRLogo.bottomAnchor, constant: 50),
            reviewUsBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            reviewUsBtn.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 40),
            reviewUsBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            reviewUsBtn.heightAnchor.constraint(equalToConstant: 90),

            termsAndConditionsBtn.topAnchor.constraint(equalTo: reviewUsBtn.bottomAnchor, constant: 14),
            termsAndConditionsBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            termsAndConditionsBtn.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 40),
            termsAndConditionsBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            termsAndConditionsBtn.heightAnchor.constraint(equalToConstant: 90),

            privacyPolicyBtn.topAnchor.constraint(equalTo: termsAndConditionsBtn.bottomAnchor, constant: 14),
            privacyPolicyBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            privacyPolicyBtn.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 40),
            privacyPolicyBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            privacyPolicyBtn.heightAnchor.constraint(equalToConstant: 90),

            reachOutBtn.topAnchor.constraint(equalTo: privacyPolicyBtn.bottomAnchor, constant: 14),
            reachOutBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            reachOutBtn.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 40),
            reachOutBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            reachOutBtn.heightAnchor.constraint(equalToConstant: 90),

            logoutBtn.topAnchor.constraint(equalTo: reachOutBtn.bottomAnchor, constant: 14),
            logoutBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoutBtn.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 40),
            logoutBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            logoutBtn.heightAnchor.constraint(equalToConstant: 90),

            deleteAccountBtn.topAnchor.constraint(equalTo: logoutBtn.bottomAnchor, constant: 50),
            deleteAccountBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        scrollView.contentSize = CGSize(width: screenWidth, height: 900)

    }

    @objc func handleReviewUsBtn() {
        /// ask to review app
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    @objc func handleTermsAndConditionsBtnPressed() {
        if let url = URL(string: "https://www.ywerise.com/terms-conditions") {
            UIApplication.shared.open(url)
        }
    }

    @objc func handlePrivacyPolicyBtnPressed() {
        if let url = URL(string: "https://www.ywerise.com/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }

    @objc func handleReachOutBtnPressed() {
        delegate?.didTapReachOut()
    }

    @objc func handleLogoutBtn() {
        delegate?.didTapLogout()
    }

    @objc func handleDeleteAccountBtn() {
        delegate?.didTapDeleteAccount()
    }

}
