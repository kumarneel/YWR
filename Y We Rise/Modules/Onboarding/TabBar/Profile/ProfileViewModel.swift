//
//  ProfileViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {

    enum Event {
        case didTapEditMotivation
        case didTapEditStyle
    }
    var eventTriggered: ((Event) -> Void)?

    @Published var user: User? = nil

    let observable = PassthroughSubject<Void, Never>()

    init() {
        getUser()
    }

    func getUser() {
        ProfileService.instance.getUser { [weak self] user in
            self?.user = user
            self?.observable.send()
        }
    }

}
