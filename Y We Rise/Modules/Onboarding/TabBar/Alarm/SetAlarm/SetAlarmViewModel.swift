//
//  SetAlarmViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/25/22.
//

import UIKit

class SetAlarmViewModel {
    enum Event {
        case didTapBackBtn
        case didTapNext(alarmString: String, snoozeTime: Int)
    }

    var eventTriggered: ((Event) -> Void)?

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }

    func didTapNext(alarmString: String, snoozeTime: Int) {
        eventTriggered?(.didTapNext(alarmString: alarmString, snoozeTime: snoozeTime))
    }
}
