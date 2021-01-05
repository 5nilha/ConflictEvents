//
//  EventsListViewModelTest.swift
//  FacebookEventsTests
//
//  Created by Fabio Quintanilha on 8/10/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import XCTest
@testable import FacebookEvents

class EventsListViewModelTest: XCTestCase, EventListDelegate {
    
    var eventListViewModel: EventsListViewModel?
    var exp: XCTestExpectation?
    
    func testEventsListViewModel() {
        
        // create the expectation
        exp = expectation(description: "Loading Events")
        
        eventListViewModel = EventsListViewModel(delegate: self)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(self.eventListViewModel?.numOfDays, 7)
        
        XCTAssertEqual(self.eventListViewModel?.sectionTitleAt(section: 0), "November 01, 2018")
        XCTAssertEqual(self.eventListViewModel?.numOfEventsOnSameDayAt(section: 0), 3)
        XCTAssertEqual(self.eventListViewModel?.eventAt(indexPath: IndexPath(row: 1, section: 0))?.title, "Yoga")
        
        XCTAssertEqual(self.eventListViewModel?.sectionTitleAt(section: 1), "November 03, 2018")
        XCTAssertEqual(self.eventListViewModel?.numOfEventsOnSameDayAt(section: 1), 2)
        XCTAssertEqual(self.eventListViewModel?.eventAt(indexPath: IndexPath(row: 0, section: 1))?.title, "Football Game")
        
        XCTAssertEqual(self.eventListViewModel?.sectionTitleAt(section: 2), "November 06, 2018")
        XCTAssertEqual(self.eventListViewModel?.numOfEventsOnSameDayAt(section: 2), 4)
        XCTAssertEqual(self.eventListViewModel?.eventAt(indexPath: IndexPath(row: 3, section: 2))?.title, "SF Coffee Festival")
    }
    
    func didUpdate() {
        exp?.fulfill()
    }
    
    func didStartLoadingEvent() {
        //Delegates for UI
    }
    
    func didEndLoadingEvent() {
        //Delegates for UI
    }
    
    func loadEventDidFail(error: RequestError) {
        //Delegates for UI
    }


}
