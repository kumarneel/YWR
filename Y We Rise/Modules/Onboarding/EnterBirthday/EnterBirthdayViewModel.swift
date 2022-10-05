//
//  EnterBirthdayViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation

class EnterBirthdayViewModel {
    enum Event {
        case didTapSaveBirthday
    }

    var eventTriggered: ((Event) -> Void)?

    func didTapSaveBirthday() {
        eventTriggered?(.didTapSaveBirthday)
    }
}
