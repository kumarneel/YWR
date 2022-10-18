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

    func didTapNext(stylesArray: [SleepStyle]) {
        let stringArr = stylesArray.map({ return $0.rawValue })
        ProfileService.instance.saveSleepStyles(styles: stringArr) { [weak self] success in
            self?.eventTriggered?(.didTapNext)
        }
    }
}
