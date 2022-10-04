//
//  GetStartedViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation

class GetStartedViewModel {
    enum Event {
        case didTapGetStarted
    }

    var eventTriggered: ((Event) -> Void)?

    func didTapGetStarted() {
        eventTriggered?(.didTapGetStarted)
    }
}
