//
//  EventTest.swift
//  FacebookEventsTests
//
//  Created by Fabio Quintanilha on 8/10/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import XCTest
@testable import FacebookEvents

class EventTest: XCTestCase {

    func testEventModel() {
        let event = Event(title: "Evening Picnic", start: "November 10, 2018 6:00 PM", end: "November 10, 2018 7:00 PM")
        XCTAssertEqual(event.title, "Evening Picnic")
        XCTAssertEqual(event.start, "November 10, 2018 6:00 PM")
        XCTAssertEqual(event.end, "November 10, 2018 7:00 PM")
        XCTAssertNotNil(event.id)
    }

}
