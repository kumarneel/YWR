//
//  VerifyPhoneNumberVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/13/22.
//

import UIKit

extension VerifyPhoneNumberVC: VerifyPhoneNumberViewDelegate {
    func didUpdateCode(code: String) {
        print("verification code: ", code)
        viewModel.code = code
        if code.count > 5 {
            sendCodeBtn.setImage(UIImage(named: "SendCodeBtnFilled"), for: .normal)
            sendCodeBtn.isUserInteractionEnabled = true
        } else {
            sendCodeBtn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
            sendCodeBtn.isUserInteractionEnabled = false
        }
    }
}
