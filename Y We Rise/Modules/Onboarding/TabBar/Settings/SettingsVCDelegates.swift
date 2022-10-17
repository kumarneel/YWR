//
//  SettingsVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/17/22.
//

import Foundation

extension SettingsVC: SettingsViewDelegate {
    func didTapLogout() {
        viewModel.didTapLogout()
    }
}
