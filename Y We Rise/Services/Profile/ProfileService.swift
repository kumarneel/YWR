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
    
    private let defaults = UserDefaults.standard

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
    
    func saveProfileImage(image: UIImage) {
        let data = image.jpegData (compressionQuality: 0.1)
        do {
            let encoded = try PropertyListEncoder ().encode (data)
            let key = "profile_image"
            print("saved image at: ", key)
            defaults.set(encoded, forKey: key)
        } catch {
            print("could not save image to cache")
        }
    }
    func getProfileImage() -> UIImage {
        let key = "profile_image"
        guard let data = defaults.data(forKey: key) else { return UIImage() }
        do {
            let decoded = try PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
            return image ?? UIImage()
        } catch {
            return UIImage()
        }
    }
}
