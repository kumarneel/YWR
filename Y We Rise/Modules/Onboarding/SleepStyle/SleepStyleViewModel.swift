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

    let isEditing: Bool

    var sleep_styles = [String]()

    init(isEditing: Bool,  sleep_styles: [String]? = nil) {
        self.isEditing = isEditing
        self.sleep_styles = sleep_styles ?? []
    }

    func didTapNext(stylesArray: [SleepStyle]) {
        let stringArr = stylesArray.map({ return $0.rawValue })
        ProfileService.instance.saveSleepStyles(styles: stringArr) { [weak self] success in
            NotificationCenter.default.post(name: Notification.Name(Observers.updateUserInfo), object: nil)
            self?.eventTriggered?(.didTapNext)
        }
    }
}
