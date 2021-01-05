//
//  EventManagerTest.swift
//  FacebookEventsTests
//
//  Created by Fabio Quintanilha on 8/10/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import XCTest
@testable import FacebookEvents

class EventManagerTest: XCTestCase, EventListDelegate {
    var manager: EventManager?
    
    override func setUp() {
        self.manager = EventManager(delegate: self)
    }

    func testCheckOverlapping() {
        guard let manager = self.manager else {
            XCTFail("Manager is nil")
            return
        }
        
        let eventVM = EventViewModel(event: Event(title: "Volleyball With Friends", start: "November 6, 2018 12:00 PM", end: "November 6, 2018 1:26 PM"))
        var eventsOnTheDay = [
            EventViewModel(event: Event(title: "Evening Cookout with Friends", start: "November 6, 2018 5:00 PM", end: "November 6, 2018 10:00 PM")),
            EventViewModel(event: Event(title: "SF Coffee Festival", start: "November 6, 2018 6:00 PM", end: "November 6, 2018 9:00 PM"))
        ]
        
        eventsOnTheDay = manager.checkConflictEvents(eventViewModel: eventVM, scheduleEventsOnDay: eventsOnTheDay)
        XCTAssertFalse(eventsOnTheDay[0].isOverlaping)
        XCTAssertFalse(eventsOnTheDay[1].isOverlaping)
        
    
        let eventVM2 = EventViewModel(event: Event(title: "Evening Cookout with Friends", start: "November 6, 2018 5:00 PM", end: "November 6, 2018 10:00 PM"))
        var eventsOnTheDay2 = [
            EventViewModel(event: Event(title: "Volleyball With Friends", start: "November 6, 2018 12:00 PM", end: "November 6, 2018 1:26 PM")),
            EventViewModel(event: Event(title: "SF Coffee Festival", start: "November 6, 2018 6:00 PM", end: "November 6, 2018 9:00 PM"))
        ]
        eventsOnTheDay2 = manager.checkConflictEvents(eventViewModel: eventVM2, scheduleEventsOnDay: eventsOnTheDay2)
        XCTAssertFalse(eventsOnTheDay2[0].isOverlaping)
        XCTAssertTrue(eventsOnTheDay2[1].isOverlaping)
    }
    
    func testCheckEvents() {
        guard let manager = self.manager else {
            XCTFail("Manager is nil")
            return
        }
        
        let events = [
            Event(title: "Evening Cookout with Friends", start: "November 6, 2018 5:00 PM", end: "November 6, 2018 10:00 PM"),
            Event(title: "Evening Picnic", start: "November 10, 2018 6:00 PM", end: "November 10, 2018 7:00 PM"),
            Event(title: "SF Coffee Festival", start: "November 6, 2018 6:00 PM", end: "November 6, 2018 9:00 PM"),
            Event(title: "Volleyball With Friends", start: "November 6, 2018 12:00 PM", end: "November 6, 2018 1:26 PM")
        ]
        

        let checkedEvents = manager.checkEvents(events: events)
        XCTAssertNotNil(checkedEvents.scheduledEvents)
        XCTAssertNotNil(checkedEvents.keys)
        XCTAssertEqual(checkedEvents.scheduledEvents.count, 2)
        XCTAssertEqual(checkedEvents.keys.count, 2)
        
        var totalEvents = 0
        for ( _ , dailyEvents) in checkedEvents.scheduledEvents {
            totalEvents += dailyEvents.count
        }
        
        XCTAssertEqual(totalEvents, 4)
    }
    
    func testGetEvents() {
        guard let manager = self.manager else {
            XCTFail("Manager is nil")
            return
        }
        
        manager.getScheduledEvents { (scheduledEvents, keys) in
            guard let allScheduledEvents = scheduledEvents else {
                XCTFail("scheduledEvents is nil")
                return
            }
            
            XCTAssertNotNil(allScheduledEvents)
            XCTAssertNotNil(keys)
            XCTAssertEqual(allScheduledEvents.count, 7)
            XCTAssertEqual(keys?.count, 7)
            
            var totalEvents = 0
            for ( _ , dailyEvents) in allScheduledEvents {
                totalEvents += dailyEvents.count
            }
            
            XCTAssertEqual(totalEvents, 21)
        }
    }
    
    
    
    func didUpdate() {
          //UIDelegate non-tested here
      }
      
      func didStartLoadingEvent() {
          //UIDelegate non-tested here
      }
      
      func didEndLoadingEvent() {
          //UIDelegate non-tested here
      }
      
      func loadEventDidFail(error: RequestError) {
          //UIDelegate non-tested here
      }
    
    
}
