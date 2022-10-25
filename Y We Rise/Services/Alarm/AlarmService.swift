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
        handler(true)
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
            defaults.set(encoded, forKey: key)
        } catch {
            print("could not save image to cache")
        }

    }

    func getSnoozeTime(alarmString: String) -> Int {
        let key = Constants.snoozeTime + alarmString
        return defaults.object(forKey: key) as? Int ?? 00
    }

    func getImage(alarmString: String) -> UIImage {
        let key = Constants.imageKey + alarmString
        guard let data = defaults.data(forKey: key) else { return UIImage() }
        do {
            let decoded = try PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
            return image ?? UIImage()
        } catch {
            return UIImage()
        }
    }


    // TODO: save images linked to alarm

    // TODO: get all alarms
    func getAlarms() {
        let alarmKeys = defaults.object(forKey: Constants.alarmKeys) as? [String] ?? []
        print(alarmKeys)
        let alarms = alarmKeys.forEach({
            print("Alarm: ", $0, getSnoozeTime(alarmString: $0), getImage(alarmString: $0))
        })
    }



    // TODO: delete alarm

    //
}
