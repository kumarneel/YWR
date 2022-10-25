//
//  SetAlarmVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/25/22.
//

import Foundation

extension SetAlarmVC: SetAlarmViewDelegate {
    func didTapNext(alarmString: String, snoozeTime: Int) {
        viewModel.didTapNext(alarmString: alarmString, snoozeTime: snoozeTime)
    }
}
