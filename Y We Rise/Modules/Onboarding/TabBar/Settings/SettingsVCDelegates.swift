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
        print("hey: ", MFMailComposeViewController.canSendMail())
        if MFMailComposeViewController.canSendMail() {
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject("Delete Account")
            mc.setMessageBody("Hi YWR, can you please delete my account?\n\nUID: \(Auth.auth().currentUser!.uid)", isHTML: false)
            mc.setToRecipients(["anthonypackwood@googlemail.com"])
            self.present(mc, animated: true, completion: nil)
        }

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
}

extension SettingsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
