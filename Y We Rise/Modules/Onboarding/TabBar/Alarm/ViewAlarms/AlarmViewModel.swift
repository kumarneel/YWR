//
//  AlarmViewModel.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/14/22.
//

import Foundation
import Combine

class AlarmViewModel {
    enum Event {
        case didTapAddNewAlarm
        case didTapViewAlarm(alarm: Alarm)
    }
    var eventTriggered: ((Event) -> Void)?

    let observable = PassthroughSubject<Void, Never>()

    @Published var alarms = [Alarm]()

    init() {
        alarms = AlarmService.instance.getAlarms()
    }

    func getAlarms() {
        alarms = AlarmService.instance.getAlarms()
        observable.send()
    }

    func didTapAddNewAlarm() {
        eventTriggered?(.didTapAddNewAlarm)
    }

    func didTapRemoveAlarm(index: Int) {
        AlarmService.instance.removeAlarm(alarmString: alarms[index].alarmString)
    }

    func didTapViewAlarm(alarm: Alarm) {
        eventTriggered?(.didTapViewAlarm(alarm: alarm))
    }
}
