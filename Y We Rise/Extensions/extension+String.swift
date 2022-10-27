//
//  extension+String.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/26/22.
//

import Foundation

extension String {
    func getDateForNotification() -> [DateComponents] {
        let time = self.dropLast(2)
        let timeSplitString = time.split(separator: ":")
        var hour = Int(timeSplitString[0]) ?? 00
        let minutes = Int(timeSplitString[1]) ?? 00
        let amPMString = String(self.suffix(2))

        if amPMString == "PM" && hour != 12 {
            hour += 12
        }

        var datesArray = [DateComponents]()

        var count = 0

        // alarm will last for 3 minutes
        while count < 180 {
            var dateInfo = DateComponents()
            let year = Calendar.current.component(.year, from: Date())
            let month = Calendar.current.component(.month, from: Date())
            let day = Calendar.current.component(.day, from: Date())

            dateInfo.day = day
            dateInfo.month = month
            dateInfo.year = year
            dateInfo.hour = hour
            dateInfo.minute = minutes
            dateInfo.second = count
            datesArray.append(dateInfo)
            count += 1
        }
        return datesArray
    }

    func getDateForSnooze(snoozeTime: Int) -> [DateComponents] {
        var datesArray = [DateComponents]()
        var count = 0
        // alarm will last for 3 minutes
        while count < 180 {
            let date = Calendar.current.date(byAdding: .minute, value: snoozeTime, to: Date())
            var component = Calendar.current.dateComponents([
                .day,
                .month,
                .year,
                .hour,
                .minute,
                .second], from: date ?? Date())
            component.second = count
            datesArray.append(component)
            count += 1
        }
        return datesArray
    }
}
