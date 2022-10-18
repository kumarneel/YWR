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

    var isEditing: Bool

    var motivation_styles = [String]()

    init(isEditing: Bool, motivation_styles: [String]? = nil) {
        self.isEditing = isEditing
        self.motivation_styles = motivation_styles ?? []
    }

    func didTapNext(stylesArray: [MotivationStyle]) {
        let strArray = stylesArray.map({ return $0.rawValue })

        ProfileService.instance.saveMotivationsStyles(styles: strArray) { [weak self] success in
            if success {
                self?.eventTriggered?(.didTapNext)
            }
        }
    }
}
