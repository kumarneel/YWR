//
//  ProfileVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import Foundation

extension ProfileVC: ProfileViewDelegate {

    func didUpdateName(name: String) {
        viewModel.updateName(name: name)
    }

    func didUpdateBirthday(date: Date) {
        viewModel.updateBirthday(date: date.timeIntervalSince1970)
    }

    func didTapEditSleepStyle() {
        viewModel.didTapEditStyle()
    }
    
    func didTapEditMotivationStyle() {
        viewModel.didTapEditMotivition()
    }
}
