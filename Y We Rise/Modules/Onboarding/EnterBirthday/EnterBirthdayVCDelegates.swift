//
//  EnterBirthdayVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import UIKit

extension EnterBirthdayVC: EnterBirthdayViewDelegate {
    func didTapDone(date: Date) {
        viewModel.didUpdateBirthday(date: date)
        nextBtn.isUserInteractionEnabled = true
        nextBtn.setImage(UIImage(named: "SendCodeBtnFilled"), for: .normal)
    }
}
