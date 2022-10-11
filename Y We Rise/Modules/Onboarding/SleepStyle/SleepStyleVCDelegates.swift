//
//  SleepStyleVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import Foundation

extension SleepStyleVC: SleepStyleViewDelegate {

    func didTapNext() {
        viewModel.didTapNext()
    }
    func didTapStyle(sleepStyle: SleepStyle, selected: Bool) {
        // TODO: Upload style to firestore
        print(sleepStyle, selected)
    }
}
