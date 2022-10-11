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

    var date = Date()

    func didTapSaveBirthday() {
        eventTriggered?(.didTapSaveBirthday)
    }

    func didUpdateBirthday(date: Date) {
        
    }
}
