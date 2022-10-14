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

    func registerPhoneNumber(phoneNumber: String, handler: @escaping (_ success: Bool, _ error: String) -> Void) {
        // fake phone auth line
//        Auth.auth().settings!.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationId, error in
            if let error = error {
                handler(false, error.localizedDescription)
            }
            CachingService.instance.saveVerificationId(verificationId: verificationId ?? "")
            handler(true, "")
        }
    }

    func verifyCode(code: String, phoneNumber: String, handler: @escaping (_ success: Bool, _ error: String, _ isNewUser: Bool) -> Void) {
        let verificationId = CachingService.instance.getVerificationId()
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("error signing in: ", error)
                handler(false, error.localizedDescription, false)
            }
            if let isNewUser = authResult?.additionalUserInfo?.isNewUser {
                if isNewUser {

                }
                handler(true, "", isNewUser)
            }
        }
    }

    func saveName(name: String, handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["name": name], merge: true) { error in
            handler(error == nil)
        }
    }

    func saveBirthday(birthday: Double, handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["birthday": birthday], merge: true) { error in
            handler(error == nil)
        }
    }

    func saveSleepStyles(styles: [String], handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["styles": styles], merge: true) { error in
            handler(error == nil)
        }
    }
    
    func saveMotivationsStyles(styles: [String], handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["styles": styles], merge: true) { error in
            handler(error == nil)
        }
    }
}
