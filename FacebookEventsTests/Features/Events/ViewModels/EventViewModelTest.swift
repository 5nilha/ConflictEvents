//
//  EventViewModelTest.swift
//  FacebookEventsTests
//
//  Created by Fabio Quintanilha on 8/9/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import XCTest
@testable import FacebookEvents

class EventViewModelTest: XCTestCase {
    
    func testEventViewModel() {
        let event = Event(title: "Evening Picnic", start: "November 10, 2018 6:00 PM", end: "November 10, 2018 7:00 PM")
        let eventViewModel = EventViewModel(event: event)
        
        XCTAssertNotNil(eventViewModel.title)
        XCTAssertEqual(eventViewModel.title, event.title)
        XCTAssertEqual(eventViewModel.title, "Evening Picnic")
        
        XCTAssertNotNil(eventViewModel.key)
        XCTAssertEqual(eventViewModel.key, 22208)
        
        XCTAssertNotNil(eventViewModel.timestampStart)
        XCTAssertEqual(eventViewModel.timestampStart, 1541872800)
        
        XCTAssertNotNil(eventViewModel.timestampEnd)
        XCTAssertEqual(eventViewModel.timestampEnd, 1541876400)
        
        XCTAssertNotNil(eventViewModel.dateStart)
        XCTAssertEqual(eventViewModel.dateStart?.timeIntervalSince1970, 1541872800)
        
        XCTAssertNotNil(eventViewModel.dateEnd)
        XCTAssertEqual(eventViewModel.dateEnd?.timeIntervalSince1970, 1541876400)
        
        XCTAssertNotNil(eventViewModel.formatedDateStart)
        XCTAssertEqual(eventViewModel.formatedDateStart, "November 10, 2018")
        
        XCTAssertNotNil(eventViewModel.formatedDateEnd)
        XCTAssertEqual(eventViewModel.formatedDateEnd, "November 10, 2018")
        
        XCTAssertNotNil(eventViewModel.startTime)
        XCTAssertEqual(eventViewModel.startTime, "6:00 PM")
        
        XCTAssertNotNil(eventViewModel.endTime)
        XCTAssertEqual(eventViewModel.endTime, "7:00 PM")
        
        
        
        let event2 = Event(title: "Evening Cookout with Friends", start: "November 6, 2018 5:00 PM", end: "November 6, 2018 10:00 PM")
        let eventViewModel2 = EventViewModel(event: event2)
        
        XCTAssertNotNil(eventViewModel2.title)
        XCTAssertEqual(eventViewModel2.title, event2.title)
        XCTAssertEqual(eventViewModel2.title, "Evening Cookout with Friends")
        
        XCTAssertNotNil(eventViewModel2.key)
        XCTAssertEqual(eventViewModel2.key, 22204)
        
        XCTAssertNotNil(eventViewModel2.timestampStart)
        XCTAssertEqual(eventViewModel2.timestampStart, 1541523600)
        
        XCTAssertNotNil(eventViewModel2.timestampEnd)
        XCTAssertEqual(eventViewModel2.timestampEnd, 1541541600)
        
        XCTAssertNotNil(eventViewModel2.dateStart)
        XCTAssertEqual(eventViewModel2.dateStart?.timeIntervalSince1970, 1541523600)
        
        XCTAssertNotNil(eventViewModel2.dateEnd)
        XCTAssertEqual(eventViewModel2.dateEnd?.timeIntervalSince1970, 1541541600)
        
        XCTAssertNotNil(eventViewModel2.formatedDateStart)
        XCTAssertEqual(eventViewModel2.formatedDateStart, "November 06, 2018")
        
        XCTAssertNotNil(eventViewModel2.formatedDateEnd)
        XCTAssertEqual(eventViewModel2.formatedDateEnd, "November 06, 2018")
        
        XCTAssertNotNil(eventViewModel2.startTime)
        XCTAssertEqual(eventViewModel2.startTime, "5:00 PM")
        
        XCTAssertNotNil(eventViewModel2.endTime)
        XCTAssertEqual(eventViewModel2.endTime, "10:00 PM")
        
    }
}
