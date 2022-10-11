//
//  FirstAlarmVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import Foundation

extension FirstAlarmVC: FirstAlarmViewDelegate {
    func didTapNext(alarmString: String) {
        viewModel.didTapNext(alarmString: alarmString)
    }
    func didTapSkip() {
        viewModel.didTapSkip()
    }
}
