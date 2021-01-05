//
//  Date+extension.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/9/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation

extension Date {
    
    static var timezone: TimeZone {
        return TimeZone(abbreviation: "UTC") ?? TimeZone.current
    }
    
    var formattedDateString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Date.timezone
        dateFormatter.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
    
    var formattedTimeWithoutSeconds: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Date.timezone
        dateFormatter.locale =  Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "h:mm a"
        let date12 = dateFormatter.string(from: self)
        return date12
    }
}
