//
//  ProfileService.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/18/22.
//

import Foundation
import Firebase

class ProfileService {
    static let instance = ProfileService()

    let db = Firestore.firestore()

    let uid = Auth.auth().currentUser!.uid

    func getUser(handler: @escaping(_ user: User) -> Void) {
        db.collection("users").document(uid).getDocument { snapshot, err in
            if err != nil { return }
            print(self.uid)
            guard let document = snapshot?.data() else { return }
            handler(User(dictionary: document))
        }
    }

    func saveName(name: String, handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(uid).setData(["name": name], merge: true) { error in
            handler(error == nil)
        }
    }

    func saveBirthday(birthday: Double, handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(uid).setData(["birthday": birthday], merge: true) { error in
            handler(error == nil)
        }
    }

    func saveSleepStyles(styles: [String], handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(uid).setData(["sleep_styles": styles], merge: true) { error in
            handler(error == nil)
        }
    }

    func saveMotivationsStyles(styles: [String], handler: @escaping(_ success: Bool) -> Void) {
        db.collection("users").document(uid).setData(["motivation_styles": styles], merge: true) { error in
            handler(error == nil)
        }
    }
}
