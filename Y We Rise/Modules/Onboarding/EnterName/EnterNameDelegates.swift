//
//  EnterNameDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

extension EnterNameVC: EnterNameViewDelegate {
    func didChangeText(text: String, canProceed: Bool) {
        if canProceed {
            nextBtn.setImage(UIImage(named: "SendCodeBtnFilled"), for: .normal)
            nextBtn.isUserInteractionEnabled = true
        } else {
            nextBtn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
            nextBtn.isUserInteractionEnabled = false
        }
    }
}
