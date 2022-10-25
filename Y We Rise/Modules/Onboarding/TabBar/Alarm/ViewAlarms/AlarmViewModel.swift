//
//  AlarmViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import Foundation

class AlarmViewModel {
    enum Event {
        case didTapAddNewAlarm
    }
    var eventTriggered: ((Event) -> Void)?

    init() {
        AlarmService.instance.getAlarms()
    }

    func didTapAddNewAlarm() {
        eventTriggered?(.didTapAddNewAlarm)
    }
}
