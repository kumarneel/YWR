//
//  MotivationStyle.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import Foundation

enum MotivationStyle: String {
    case family = "family"
    case wealth = "wealth"
    case cars = "cars"
    case love = "love"
    case career = "careers"
    case kids = "kids"
    case fame = "fame"
    case health = "health"
    case winning = "winning"
    case power = "power"
    case partner = "partner"
    case fear = "fear"
}

extension MotivationStyle {
    func getCorrectMotivation(name: String) -> MotivationStyle {
        if name == MotivationStyle.family.rawValue {
            return .family
        } else if name == MotivationStyle.wealth.rawValue {
            return .wealth
        } else if name == MotivationStyle.cars.rawValue {
            return .cars
        } else if name == MotivationStyle.love.rawValue {
            return .love
        } else if name == MotivationStyle.career.rawValue {
            return .career
        } else if name == MotivationStyle.kids.rawValue {
            return .kids
        } else if name == MotivationStyle.fame.rawValue {
            return .fame
        } else if name == MotivationStyle.health.rawValue {
            return .health
        } else if name == MotivationStyle.winning.rawValue {
            return .winning
        } else if name == MotivationStyle.power.rawValue {
            return .power
        } else if name == MotivationStyle.partner.rawValue {
            return .partner
        } else {
            return .fear
        }
    }
}


