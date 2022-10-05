//
//  USTextField.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/4/22.
//

import Foundation
import PhoneNumberKit

class MyUSTextField: PhoneNumberTextField {
    override var defaultRegion: String {
        get {
            return "US"
        }
        set {} // exists for backward compatibility
    }
}
