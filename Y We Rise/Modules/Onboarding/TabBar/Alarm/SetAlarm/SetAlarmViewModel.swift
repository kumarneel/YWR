//
//  SetAlarmViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/25/22.
//

import Foundation

class SetAlarmViewModel {
    enum Event {
        case didTapBackBtn
    }
    var eventTriggered: ((Event) -> Void)?

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }
}
