//
//  OnboardingService.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/13/22.
//

import Foundation
import Firebase
import FirebaseAuth

class OnboardingService {
    static let instance = OnboardingService()

    let db = Firestore.firestore()

    func saveName(name: String, handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["name": name]) { error in
            handler(error == nil)
        }
    }

    func saveBirthday(birthday: String, handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["birthday": birthday]) { error in
            handler(error == nil)
        }
    }

    func saveSleepStyles(styles: [String], handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["styles": styles]) { error in
            handler(error == nil)
        }
    }
    
    func saveMotivationsStyles(styles: [String], handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["styles": styles]) { error in
            handler(error == nil)
        }
    }
}
