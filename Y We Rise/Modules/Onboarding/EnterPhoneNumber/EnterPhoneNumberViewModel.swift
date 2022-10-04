//
//  EnterPhoneNumberViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation

class EnterPhoneNumberViewModel {
    enum Event {
        case didTapBackBtn
    }

    var eventTriggered: ((Event) -> Void)?

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }
}

