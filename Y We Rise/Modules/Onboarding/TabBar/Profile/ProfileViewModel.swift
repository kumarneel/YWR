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
        case didTapEditMotivation(motivationStyles: [String])
        case didTapEditStyle(sleepStyles: [String])
    }
    var eventTriggered: ((Event) -> Void)?

    @Published var user: User? = nil

    let observable = PassthroughSubject<Void, Never>()

    func viewWillAppear() {
        getUser()
        self.observable.send()
    }

    func getUser() {
        ProfileService.instance.getUser { [weak self] user in
            self?.user = user
            self?.observable.send()
        }
    }

    func updateName(name: String) {
        ProfileService.instance.saveName(name: name) { [weak self] success in
            if success {
                self?.user?.name = name
            }
        }
    }

    func updateBirthday(date: Double) {
        ProfileService.instance.saveBirthday(birthday: date) { [weak self] success in
            if success {
                self?.user?.birthday = Int(date)
            }
        }
    }

    func didTapEditMotivition() {
        guard let user = user else { return }
        eventTriggered?(.didTapEditMotivation(motivationStyles: user.motivation_styles))
    }

    func didTapEditStyle() {
        guard let user = user else { return }
        eventTriggered?(.didTapEditStyle(sleepStyles: user.sleep_styles))
    }
}
