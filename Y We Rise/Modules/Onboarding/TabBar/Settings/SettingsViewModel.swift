//
//  SettingsViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import Foundation
import Firebase

class SettingsViewModel {
    enum Event {
        case didTapLogout
        case didTapViewAlarm(alarm: Alarm)
    }
    var eventTriggered: ((Event) -> Void)?

    func didTapLogout() {
        do{
            try Auth.auth().signOut()
            eventTriggered?(.didTapLogout)
        }catch{
            print("there was an error trying to log out")
        }
    }
    func didTapViewAlarm(alarm: Alarm) {
        eventTriggered?(.didTapViewAlarm(alarm: alarm))
    }
    
}
