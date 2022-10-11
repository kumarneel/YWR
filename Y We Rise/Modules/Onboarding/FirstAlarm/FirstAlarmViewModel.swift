//
//  FirstAlarmViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/7/22.
//

import Foundation

class FirstAlarmViewModel {
    enum Event {
        case didTapNext
        case didTapSkip
    }
    var eventTriggered: ((Event) -> Void)?

    func didTapNext() {
        eventTriggered?(.didTapNext)
    }
    func didTapSkip() {
        eventTriggered?(.didTapSkip)
    }
}
