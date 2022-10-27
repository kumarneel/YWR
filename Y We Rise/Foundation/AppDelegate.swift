//
//  AppDelegate.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/3/22.
//

import UIKit
import Firebase
import FirebaseAuth
import AudioToolbox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let userNotificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        attemptRegisterForNotifications()

        NotificationCenter.default.addObserver(self, selector: #selector(handleSetNewAlarm), name: Notification.Name(Observers.setNewAlarm), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleSnoozeAlarm), name: Notification.Name(Observers.snoozeAlarm), object: nil)
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // notification segueing
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        let alarmString = userInfo["alarmString"] as? String ?? ""
        NotificationCenter.default.post(name: Notification.Name(Observers.tappedAlarm), object: nil, userInfo: ["alarmString": alarmString])
        completionHandler()
    }


    @objc func handleSetNewAlarm(notification: Notification) {
        if let alarmString = notification.userInfo?["alarmString"] as? String {
            setAlarmNotification(alarmString: alarmString)
        }
    }

    @objc func handleSnoozeAlarm(notification: Notification) {
        if let alarmString = notification.userInfo?["alarmString"] as? String {
            if let snoozeTime = notification.userInfo?["snoozeTime"] as? Int {
                snoozeAlarmNotification(alarmString: alarmString, snoozeTime: snoozeTime)
            }
        }
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {

    func attemptRegisterForNotifications() {
        userNotificationCenter.delegate = self
        userNotificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print("Permission granted: \(granted)")
            if granted {

            }
        }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

    func setAlarmNotification(alarmString: String) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "Y We Rise"
        notificationContent.body = "ALARM"
        notificationContent.userInfo = ["alarmString": alarmString]
        notificationContent.sound = UNNotificationSound.default

        var count = 0
        for alarmDate in alarmString.getDateForNotification() {
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: alarmDate, repeats: false)
            let request = UNNotificationRequest(identifier: alarmString + "\(count)",
                                                content: notificationContent,
                                                trigger: trigger)
            /// reset delegate to remove bug
            userNotificationCenter.delegate = self
            userNotificationCenter.add(request) { (error) in
                print("registered notification")
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
            count += 1
        }
    }
    func snoozeAlarmNotification(alarmString: String, snoozeTime: Int) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "Y We Rise"
        notificationContent.body = "ALARM"
        notificationContent.userInfo = ["alarmString": alarmString]
        notificationContent.sound = UNNotificationSound.default

        var count = 0
        for alarmDate in alarmString.getDateForSnooze(snoozeTime: snoozeTime) {
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: alarmDate, repeats: false)
            let request = UNNotificationRequest(identifier: alarmString + "\(count)",
                                                content: notificationContent,
                                                trigger: trigger)
            /// reset delegate to remove bug
            userNotificationCenter.delegate = self
            userNotificationCenter.add(request) { (error) in
                print("registered notification")
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
            count += 1
        }
    }
}
