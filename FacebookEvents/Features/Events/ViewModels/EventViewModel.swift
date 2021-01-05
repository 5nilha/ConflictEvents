//
//  EventViewModel.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/8/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation

class EventViewModel: Decodable {
    
    private let event: Event?
    var isOverlaping = false
    var overlappingWith: String?
    
    init(event: Event) {
        self.event = event
    }
    
    deinit {
        print("deinitializing EventViewModel for \(String(describing: title))")
    }
    
    var key: Int? {
        var calendar = Calendar.current
        guard let dateStart = self.dateStart else { return nil }
        calendar.timeZone = Date.timezone
        let day = calendar.component(.day, from: dateStart)
        let month = calendar.component(.month, from: dateStart)
        let year = calendar.component(.year, from: dateStart)
        return (month * year) + day
    }
    
    var title: String? {
        return event?.title
    }
    
    var timestampStart: Int? {
        guard let dateStart = self.dateStart else { return nil }
        return Int(dateStart.timeIntervalSince1970)
    }
    
    var timestampEnd: Int? {
        guard let dateEnd = self.dateEnd else { return nil }
        return Int(dateEnd.timeIntervalSince1970)
    }
    
    var dateStart: Date? {
        return parsedDate(dateString: self.event?.start)
    }
    
    var dateEnd: Date? {
        return parsedDate(dateString: self.event?.end)
    }
    
    var formatedDateStart: String? {
        return dateStart?.formattedDateString
    }
    
    var formatedDateEnd: String? {
        return dateEnd?.formattedDateString
    }
    
    var startTime: String? {
        return dateStart?.formattedTimeWithoutSeconds
    }
    
    var endTime: String? {
        return dateEnd?.formattedTimeWithoutSeconds
    }

    private func parsedDate(dateString: String?) -> Date? {
        guard let dateStr = dateString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy h:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: dateStr)
        return date
    }
}
