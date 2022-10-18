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

    var date: Double = 0.0

    func didTapSaveBirthday() {
        ProfileService.instance.saveBirthday(birthday: date) { [weak self] success in
            if success {
                self?.eventTriggered?(.didTapSaveBirthday)
            }
        }
    }
}
