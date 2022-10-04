//
//  VerifyPhoneNumberViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation

class VerifyPhoneNumberViewModel {
    enum Event {
        case didTapBackBtn
        case didTapVerifyCode
    }

    var eventTriggered: ((Event) -> Void)?

    func didTapVerifyCode() {
        eventTriggered?(.didTapVerifyCode)
    }

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }
}

