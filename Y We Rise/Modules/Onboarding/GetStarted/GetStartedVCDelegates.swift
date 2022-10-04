//
//  GetStartedVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation

extension GetStartedVC: GetStartedViewDelegate {
    func didTapGetStartedBtn() {
        viewModel.didTapGetStarted()
    }
}
