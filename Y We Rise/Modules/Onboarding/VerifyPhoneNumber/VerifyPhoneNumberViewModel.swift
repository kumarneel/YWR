//
//  VerifyPhoneNumberViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation
import Combine

class VerifyPhoneNumberViewModel: ObservableObject {
    enum Event {
        case didTapBackBtn
        case didVerifyCode(isNewUser: Bool)
    }

    var eventTriggered: ((Event) -> Void)?

    @Published var error: String = ""
    @Published var verified: Bool = false

    let phoneNumber: String
    private var isNewUser = false
    var code: String = ""

    let observable = PassthroughSubject<Void, Never>()

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

    func didTapVerifyCode() {
        OnboardingService.instance.verifyCode(code: code, phoneNumber: phoneNumber) { [weak self] success, error, isNewUser in
            self?.verified = success
            self?.error = error
            self?.isNewUser = isNewUser
            self?.observable.send()
        }
    }

    func didVerify() {
        eventTriggered?(.didVerifyCode(isNewUser: isNewUser))
    }

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }
}

