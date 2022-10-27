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
        NotificationCenter.default.addObserver(self, selector: #selector(handleRemoveAlarm), name: Notification.Name(Observers.removeAlarm), object: nil)

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }


    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("user info: ", userInfo)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    @objc func handleSetNewAlarm(notification: Notification) {
        if let alarmString = notification.userInfo?["alarmString"] as? String {
            setAlarmNotification(alarmString: alarmString)
        }
    }

    @objc func handleRemoveAlarm(notification: Notification) {
        if let alarmString = notification.userInfo?["alarmString"] as? String {
            removeAlarmNotification(alarmString: alarmString)
            print("removing alarm: ", alarmString)
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


    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("handler")

        // TODO: Send annoying notification
        completionHandler([.badge, .sound, .alert])
    }

    func setAlarmNotification(alarmString: String) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "Y We Rise"
        notificationContent.body = "ALARM"
        notificationContent.userInfo = ["alarmString": alarmString]

        var count = 0
        for alarmDate in alarmString.getDateForNotification() {
            let date = Calendar.current.date(from: alarmDate) ?? Date()
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

    func removeAlarmNotification(alarmString: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (reqs) in
            var ids =  [String]()
            reqs.forEach {
                if $0.identifier == alarmString {
                    ids.append($0.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers:ids)
        }
    }
}
