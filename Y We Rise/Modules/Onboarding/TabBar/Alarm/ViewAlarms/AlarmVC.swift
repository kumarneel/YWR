//
//  AlarmVC.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import UIKit
import Combine
import UserNotifications

class AlarmVC: BaseViewController<AlarmViewModel> {

    lazy var controllerView: AlarmView = {
        let v = AlarmView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        return v
    }()

    private var cancellables: Set<AnyCancellable> = []

    let userNotificationCenter = UNUserNotificationCenter.current()

    var tappedAlarm = false

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewController()
        viewModel.getAlarms()
        tabBarController?.tabBar.isHidden = false

    }

    func bindViewModel() {
        viewModel.observable.sink { [weak self] in
            guard let self = self else { return }
            self.controllerView.configure(viewModel: self.viewModel)
        }.store(in: &cancellables)

        NotificationCenter.default.addObserver(self, selector: #selector(handleAddedNewAlarm), name: Notification.Name(Observers.addedNewAlarm), object: nil)
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

    @objc func handleAddedNewAlarm() {
        viewModel.getAlarms()
    }
}

extension AlarmVC {
    func setupViewController() {
        navigationItem.setHidesBackButton(true, animated: true)
        addControllerView(controllerView)
        controllerView.configure(viewModel: viewModel)
    }
}
