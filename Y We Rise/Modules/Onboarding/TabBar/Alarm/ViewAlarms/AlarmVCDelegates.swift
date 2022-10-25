//
//  AlarmVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/24/22.
//

import Foundation

extension AlarmVC: AlarmViewDelegate {
    func didTapAddNewAlarm() {
        viewModel.didTapAddNewAlarm()
    }
}
