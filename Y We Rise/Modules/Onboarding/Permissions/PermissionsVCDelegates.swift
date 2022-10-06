//
//  PermissionsVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/6/22.
//

import UIKit
import UserNotifications

extension PersmissionsVC: PermissionsViewDelegate {

    func didTapSwitch() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if error == nil {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    func didTapNext() {
        viewModel.didTapNext()
    }
}
