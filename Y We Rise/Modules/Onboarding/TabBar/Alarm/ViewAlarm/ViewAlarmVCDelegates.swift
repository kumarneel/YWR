//
//  ViewAlarmVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/26/22.
//

import Foundation

extension ViewAlarmVC: ViewAlarmViewDelegate {
    func didTapSnooze(alarm: Alarm) {
        viewModel.didTapSnooze(alarm: alarm)
    }

    func didTapStop(alarm: Alarm) {
        viewModel.didTapStop(alarm: alarm)
    }
}
