//
//  EnterPhoneNumberViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation
import Combine

class EnterPhoneNumberViewModel: ObservableObject {
    enum Event {
        case didTapBackBtn
        case didTapSendCode(phoneNumber: String)
    }

    var eventTriggered: ((Event) -> Void)?

    var phoneNumber: String = ""

    @Published var error: String = ""

    let observable = PassthroughSubject<Void, Never>()

    func didTapSendCode() {
        print(phoneNumber)
        OnboardingService.instance.registerPhoneNumber(phoneNumber: phoneNumber) { [weak self] success, error in
            if success {
                self?.eventTriggered?(.didTapSendCode(phoneNumber: self?.phoneNumber ?? ""))
            }

        }
    }

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }
}

