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

    func didTapAddNewAlarm() {
        eventTriggered?(.didTapAddNewAlarm)
        print("add alarm")
    }
}
