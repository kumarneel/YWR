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
    }
    var eventTriggered: ((Event) -> Void)?

    var alarmString: String

    init(alarmString: String) {
        self.alarmString = alarmString
    }

    func didTapNext(alarmString: String) {
        eventTriggered?(.didTapNext)
    }

}
