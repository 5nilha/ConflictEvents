//
//  EventServicesTest.swift
//  FacebookEventsTests
//
//  Created by Fabio Quintanilha on 8/10/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import XCTest
@testable import FacebookEvents

class EventServicesTest: XCTestCase {

    func testEventCalendarLookup() {
        let eventService = EventsService()
        eventService.eventsCalendarLookup { (result) in
            switch(result) {
            case .success(let events):
                XCTAssertNotNil(events)
                XCTAssertEqual(events.count, 21)
            case .failure(let error):
                XCTFail("EventCalendarLookup200StatusSuccess fail. \(error.description)")
            }
        }
    }

}
