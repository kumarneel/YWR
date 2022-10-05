//
//  EnterPhoneNumberVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import UIKit

extension EnterPhoneNumberVC: EnterPhoneNumberViewDelegate {
    func didUpdateTextField(_ text: String) {
        if isValidPhoneNumber(phoneNumber: text) {
            sendCodeBtn.isUserInteractionEnabled = true
            sendCodeBtn.setImage(UIImage(named: "SendCodeBtnFilled"), for: .normal)

        } else {
            sendCodeBtn.isUserInteractionEnabled = false
            sendCodeBtn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
        }
    }
}
