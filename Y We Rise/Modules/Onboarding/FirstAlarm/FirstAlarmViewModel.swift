//
//  FirstAlarmViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/7/22.
//

import Foundation

class FirstAlarmViewModel {
    enum Event {
        case didTapNext(alarmString: String)
        case didTapSkip
    }
    var eventTriggered: ((Event) -> Void)?

    func didTapNext(alarmString: String) {
        eventTriggered?(.didTapNext(alarmString: alarmString))
    }
    func didTapSkip() {
        eventTriggered?(.didTapSkip)
    }
}
