//
//  ViewAlarmViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/26/22.
//

import Foundation

class ViewAlarmViewModel {
    enum Event {
        case didTapStop
        case didTapSnooze
    }
    var eventTriggered: ((Event) -> Void)?

    let alarm: Alarm

    init(alarm: Alarm) {
        self.alarm = alarm
    }

    func didTapStop(alarm: Alarm) {
        AlarmService.instance.removeAlarmNotification(alarmString: alarm.alarmString)
        AlarmService.instance.changeActiveStatus(isActive: false, alarmString: alarm.alarmString)
        eventTriggered?(.didTapStop)
    }

    func didTapSnooze(alarm: Alarm) {
        AlarmService.instance.removeAlarmNotification(alarmString: alarm.alarmString)
        NotificationCenter.default.post(name: Notification.Name(Observers.snoozeAlarm), object: nil, userInfo: ["alarmString": alarm.alarmString, "snoozeTime": alarm.snoozeTime])
        eventTriggered?(.didTapSnooze)
    }
}
