//
//  CachingService.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/13/22.
//

import Foundation

class CachingService {
    static let instance = CachingService()

    /// add new cache item here
    struct Constants {
        static let authVerificationId = "auth_verification_id"

    }

    private let defaults = UserDefaults.standard

    // MARK: Region User

    func saveVerificationId(verificationId: String) {
        defaults.set(verificationId, forKey: Constants.authVerificationId)
    }

    func getVerificationId() -> String {
        return defaults.object(forKey: Constants.authVerificationId) as? String ?? ""
    }

    func clearCache() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach {
            defaults.removeObject(forKey: $0)
        }
        defaults.synchronize()
    }
}
