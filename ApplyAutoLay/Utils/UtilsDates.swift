//
//  UtilsDates.swift
//  ApplyAutoLay
//
//  Created by Jose Preatorian on 04-12-24.
//
import Foundation

class UtilsDates {
    
    func timerAgoSet(from isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        guard let date = isoFormatter.date(from: isoDate) else {
            return "Invalid Date"
        }

        let now = Date()
        let calendar = Calendar.current

        let components = calendar.dateComponents(
            [.minute, .hour, .day],
            from: date,
            to: now
        )

        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        } else if let day = components.day, day == 1 {
            return "Yesterday"
        } else if let hour = components.hour, hour >= 1 {
            return "\(hour) hour\(hour > 1 ? "s" : "") ago"
        } else if let minute = components.minute, minute >= 1 {
            return "\(minute) minute\(minute > 1 ? "s" : "") ago"
        } else {
            return "Now"
        }
    }
}
