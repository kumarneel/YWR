//
//  AppDelegate.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/3/22.
//

import UIKit
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let userNotificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        attemptRegisterForNotifications()
        sendAnnoyingNotification()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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
        UIApplication.shared.registerForRemoteNotifications()
    }

    @objc func sendAnnoyingNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Y We Rise"
        notificationContent.body = "ALARM"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: "annoyingNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        /// reset delegate to remove bug
        userNotificationCenter.delegate = self
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
