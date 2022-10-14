//
//  MotivationStyleViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import Foundation

class MotivationStyleViewModel {
    
    enum Event {
        case didTapNext
    }

    var eventTriggered: ((Event) -> Void)?

    func didTapNext(stylesArray: [MotivationStyle]) {
        let strArray = stylesArray.map({ return $0.rawValue })

        OnboardingService.instance.saveMotivationsStyles(styles: strArray) { [weak self] success in
            if success {
                self?.eventTriggered?(.didTapNext)
            }
        }
    }
}
