//
//  AddMotivationViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import Foundation

class AddMotivationViewModel {

    enum Event {
        case didTapNext
        case didTapBackBtn
    }
    var eventTriggered: ((Event) -> Void)?

    var alarmString: String

    var snoozeTime: Int

    var isOnboarding: Bool

    init(alarmString: String, snoozeTime: Int = 0, isOnboarding: Bool = true) {
        self.alarmString = alarmString
        self.snoozeTime = snoozeTime
        self.isOnboarding = isOnboarding
    }

    func didTapNext(alarmString: String) {
        eventTriggered?(.didTapNext)
    }

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }

}
