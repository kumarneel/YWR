//
//  User.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import Foundation


struct User {
    var birthday: Int
    var motivation_styles: [String]
    var sleep_styles: [String]
    var name: String

    init(dictionary: [String: Any]) {
        self.birthday = dictionary["birthday"] as? Int ?? 0
        self.motivation_styles = dictionary["motivation_styles"] as? [String] ?? []
        self.sleep_styles = dictionary["sleep_styles"] as? [String] ?? []
        self.name = dictionary["name"] as? String ?? ""
    }
}
