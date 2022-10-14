//
//  EnterNameViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation

class EnterNameViewModel {
    enum Event {
        case didTapSaveName
    }

    var eventTriggered: ((Event) -> Void)?

    var name: String = ""

    func didTapSaveName() {
        OnboardingService.instance.saveName(name: name) { [weak self] success in
            if success {
                self?.eventTriggered?(.didTapSaveName)
            }
        }
    }
}
