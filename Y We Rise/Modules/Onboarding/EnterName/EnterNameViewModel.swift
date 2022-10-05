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

    func didTapSaveName() {
        eventTriggered?(.didTapSaveName)
    }
}
