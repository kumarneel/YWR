//
//  SleepStyleVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit

extension SleepStyleVC: SleepStyleViewDelegate {

    func didTapNext() {
        controllerView.nextBtn.setImage(UIImage(named: "SendCodeBtnUnfilled"), for: .normal)
        controllerView.nextBtn.isUserInteractionEnabled = false
        controllerView.activityView.startAnimating()
        viewModel.didTapNext(stylesArray: selectedSleepStyleArray)
    }

    func didTapSave() {
        controllerView.activityView.startAnimating()
        viewModel.didTapNext(stylesArray: selectedSleepStyleArray)
    }

    func didTapStyle(sleepStyle: SleepStyle, selected: Bool) {
        if selected {
            selectedSleepStyleArray.append(sleepStyle)
        } else {
            for i in 0...selectedSleepStyleArray.count-1 {
                if selectedSleepStyleArray[i] == sleepStyle {
                    selectedSleepStyleArray.remove(at: i)
                    break // crash fix
                }
            }
        }
    }
}
