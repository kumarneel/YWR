//
//  PermissionsViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import Foundation

class PermissionsViewModel {
    enum Event {
        case didTapNext
    }

    var eventTriggered: ((Event) -> Void)?

    func didTapNext() {
        eventTriggered?(.didTapNext)
    }
}
