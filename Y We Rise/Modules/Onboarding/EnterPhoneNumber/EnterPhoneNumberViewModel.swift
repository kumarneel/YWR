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
        case didTapSendCode
    }

    var eventTriggered: ((Event) -> Void)?

    var phoneNumber: String = ""

    func didTapSendCode() {
        print(phoneNumber)
        OnboardingService.instance.registerPhoneNumber(phoneNumber: phoneNumber) { [weak self] success, error in
            print(success, error)
//            self?.eventTriggered?(.didTapSendCode)
        }
    }

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }
}

