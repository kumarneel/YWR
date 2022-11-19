//
//  AddMotivationViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import UIKit

class AddMotivationViewModel {

    enum Event {
        case didTapNext
        case didTapBackBtn
    }
    var eventTriggered: ((Event) -> Void)?

    var alarmString: String

    var snoozeTime: Int

    var isOnboarding: Bool

    var image1: UIImage?
    var image2: UIImage?
    var image3: UIImage?
    var image4: UIImage?

    init(alarmString: String, snoozeTime: Int = 0, isOnboarding: Bool = true) {
        self.alarmString = alarmString
        self.snoozeTime = snoozeTime
        self.isOnboarding = isOnboarding
    }

    func didTapNext() {
        var motivationalImages = [UIImage]()
        [image1, image2, image3, image4].forEach({
            guard let image = $0 else { return }
            motivationalImages.append(image)
        })
        AlarmService.instance.createNewAlarm(alarmString: alarmString, images: motivationalImages, snoozeTime: snoozeTime) { [weak self] success in
            self?.eventTriggered?(.didTapNext)
        }
    }

    func didTapBackBtn() {
        eventTriggered?(.didTapBackBtn)
    }

}
