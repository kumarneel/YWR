//
//  SettingsVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit

class SettingsVC: BaseViewController<SettingsViewModel> {

    lazy var controllerView: SettingsView = {
        let v = SettingsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()
    
    var tappedAlarm = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
        NotificationCenter.default.addObserver(self, selector: #selector(handleViewingAlarm), name: Notification.Name(Observers.tappedAlarm), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handeSnoozedAlarm), name: Notification.Name(Observers.snoozeAlarm), object: nil)
    }

    @objc func handleViewingAlarm(notification: Notification) {
        if let alarmString = notification.userInfo?["alarmString"] as? String {
            guard let alarm = AlarmService.instance.getAlarm(alarmString: alarmString) else { return }
            if alarm.isActive && !tappedAlarm {
                viewModel.didTapViewAlarm(alarm: alarm)
                tappedAlarm = true
            }
        }
    }
    @objc func handeSnoozedAlarm() {
        tappedAlarm = false
    }
}

extension SettingsVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
    }
}
