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
        if selected {
            selectedSleepStyleArray.append(sleepStyle)
        } else {
            for i in 0...selectedSleepStyleArray.count-1 {
                if selectedSleepStyleArray[i] == sleepStyle {
                    selectedSleepStyleArray.remove(at: i)
                }
            }
        }
        print(selectedSleepStyleArray)
    }
}
