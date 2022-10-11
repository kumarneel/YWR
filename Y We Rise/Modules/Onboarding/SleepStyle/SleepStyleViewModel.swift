//
//  SleepStyleViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import Foundation

class SleepStyleViewModel {
    enum Event {
        case didTapNext
    }

    var eventTriggered: ((Event) -> Void)?

    func didTapNext() {
        eventTriggered?(.didTapNext)
    }
    // TODO: Upload style to firestore

}
