//
//  User.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import Foundation


struct User {
    let birthday: Int
    let motivation_styles: [String]
    let sleep_styles: [String]
    let name: String

    init(dictionary: [String: Any]) {
        self.birthday = dictionary["birthday"] as? Int ?? 0
        self.motivation_styles = dictionary["motivation_styles"] as? [String] ?? []
        self.sleep_styles = dictionary["sleep_styles"] as? [String] ?? []
        self.name = dictionary["name"] as? String ?? ""
    }
}
