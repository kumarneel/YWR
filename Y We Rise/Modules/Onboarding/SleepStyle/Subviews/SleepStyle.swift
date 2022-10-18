//
//  SleepStyle.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import Foundation

enum SleepStyle: String {
    case nightOwl = "nightOwl"
    case earlyBird = "earlyBird"
    case wakerUpper = "wakerUpper"
}

extension SleepStyle {
    func getCorrectStyle(name: String) -> SleepStyle {
        if name == SleepStyle.earlyBird.rawValue {
            return .earlyBird
        } else if name == SleepStyle.nightOwl.rawValue {
            return .nightOwl
        } else {
            return .wakerUpper
        }
    }
}
