//
//  AlarmService.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/25/22.
//

import UIKit

class AlarmService {
    static let instance = AlarmService()

    /// add new cache item here
    struct Constants {
        static let alarmKeys = "alarmKeys"
        static let imageKey = "imageKey"
        static let snoozeTime = "snoozeTime"
        static let imageCount = "imageCount"
        static let isActive = "isActive"
    }

    private let defaults = UserDefaults.standard

    func createNewAlarm(alarmString: String, images: [UIImage], snoozeTime: Int, handler: @escaping(_ success: Bool) -> Void) {

        var alarmKeys = defaults.object(forKey: Constants.alarmKeys) as? [String] ?? []
        alarmKeys.append(alarmString)
        defaults.set(alarmKeys, forKey: Constants.alarmKeys)

        saveSnoozeTime(time: snoozeTime, alarmString: alarmString)

        for i in 0...images.count-1 {
            saveImage(image: images[i], alarmString: alarmString, index: i)
        }
        saveImageCount(alarmString: alarmString, count: images.count)
        changeActiveStatus(isActive: true, alarmString: alarmString)
        handler(true)
    }

    func changeActiveStatus(isActive: Bool, alarmString: String) {
        let key = Constants.isActive + alarmString
        defaults.set(isActive, forKey: key)
    }

    func saveSnoozeTime(time: Int, alarmString: String) {
        let key = Constants.snoozeTime + alarmString
        defaults.set(time, forKey: key)
    }

    func saveImage(image: UIImage, alarmString: String, index: Int) {
        let data = image.jpegData (compressionQuality: 0.5)
        do {
            let encoded = try PropertyListEncoder ().encode (data)
            let key = Constants.imageKey + alarmString + "\(index)"
            print("saved image at: ", key)
            defaults.set(encoded, forKey: key)
        } catch {
            print("could not save image to cache")
        }
    }

    func saveImageCount(alarmString: String, count: Int) {
        let key = Constants.imageKey + alarmString
        defaults.set(count, forKey: key)
    }

    func getSnoozeTime(alarmString: String) -> Int {
        let key = Constants.snoozeTime + alarmString
        return defaults.object(forKey: key) as? Int ?? 00
    }


    func getImageCount(alarmString: String) -> Int {
        let key = Constants.imageKey + alarmString
        return defaults.object(forKey: key) as? Int ?? 00
    }

    func getActiveStatus(alarmString: String) -> Bool {
        let key = Constants.isActive + alarmString
        return defaults.object(forKey: key) as? Bool ?? false
    }

    func getImage(alarmString: String, index: Int) -> UIImage {
        let key = Constants.imageKey + alarmString + "\(index)"
        guard let data = defaults.data(forKey: key) else { return UIImage() }
        do {
            let decoded = try PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
            return image ?? UIImage()
        } catch {
            return UIImage()
        }
    }

    func getAlarms() -> [Alarm] {
        var alarms = [Alarm]()
        let alarmKeys = defaults.object(forKey: Constants.alarmKeys) as? [String] ?? []
        print(alarmKeys)
        alarmKeys.forEach({
            let snoozeTime = getSnoozeTime(alarmString: $0)
            let imageCount = getImageCount(alarmString: $0)
            let isActive = getActiveStatus(alarmString: $0)

            var images = [UIImage]()
            if imageCount != 0 {
                for i in 0...imageCount-1 {
                    images.append(getImage(alarmString: $0, index: i))
                }
            }

            alarms.append(Alarm(alarm: $0, snoozeTime: snoozeTime, images: images, isActive: isActive))
        })
        return alarms
    }

    func removeAlarm(alarmString: String){
        var alarmKeys = defaults.object(forKey: Constants.alarmKeys) as? [String] ?? []
        for i in 0...alarmKeys.count-1 {
            if alarmKeys[i] == alarmString {
                alarmKeys.remove(at: i)
                break
            }
        }
        defaults.set(alarmKeys, forKey: Constants.alarmKeys)
        // TODO: Remove dangling images
    }
}
