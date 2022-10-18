//
//  ProfileVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import Foundation

extension ProfileVC: ProfileViewDelegate {
    func didTapEditSleepStyle() {
        viewModel.didTapEditStyle()
    }
    func didTapEditMotivationStyle() {
        viewModel.didTapEditMotivition()
    }
}
