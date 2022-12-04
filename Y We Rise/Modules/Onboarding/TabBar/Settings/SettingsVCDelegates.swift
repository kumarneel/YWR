//
//  SettingsVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/17/22.
//

import Foundation
import MessageUI
import Firebase
import StoreKit

extension SettingsVC: SettingsViewDelegate {
    func didTapDeleteAccount() {
        let alert = UIAlertController(title: "Account Deletion", message: "Are you sure you want to delete your account. This cannot be undone.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "whoops", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.viewModel.clearCache()
            self?.viewModel.deleteAccount()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func didTapReachOut() {
        if MFMailComposeViewController.canSendMail() {
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject("Reaching out!")
            mc.setMessageBody("Hi YWR!\n", isHTML: false)
            mc.setToRecipients(["anthonypackwood@googlemail.com"])
            self.present(mc, animated: true, completion: nil)
        }
    }

    func didTapLogout() {
        viewModel.didTapLogout()
    }
    
    func didTapClearCache() {
        let alert = UIAlertController(title: "Cache", message: "Would you like to clear your Cache? This will remove saved alarms and your profile image.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "whoops", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.viewModel.clearCache()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
