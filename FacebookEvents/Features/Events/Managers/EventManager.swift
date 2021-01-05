//
//  EventManager.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/9/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation


class EventManager {
    
    private weak var delegate: EventListDelegate?
    
    init(delegate: EventListDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        print("deinitializing EventManager")
    }
    
    func getScheduledEvents(completion: @escaping (_ scheduledEvents: [Int: [EventViewModel]]?, _ keys: [Int]?) -> Void) {

        let eventsService = EventsService()
        eventsService.eventsCalendarLookup { [weak self] (result) in
            switch(result){
            case .success(let events):
                let checkedEvents = self?.checkEvents(events: events)
                completion(checkedEvents?.scheduledEvents, checkedEvents?.keys)
            case .failure(let error):
                self?.delegate?.loadEventDidFail(error: error)
                completion(nil, nil)
            }
        }
    }
    
    
    /*
     * CheckEvents Method has a Time Complexity of Big O(n * d * (s log s)) which (n > d > s) and the total is less than O(n^2)
     * It runs the events list n time which n is the total numebrs of events
     * In each run an EventViewModel property is created
     *
     */
    func checkEvents(events: [Event]) -> (scheduledEvents: [Int: [EventViewModel]], keys: [Int]) {
        
        var scheduledEvents = [Int: [EventViewModel]]()
        var keys = [Int]()
        
        for event in events {
            let eventViewModel = EventViewModel(event: event)
            
            if let key = eventViewModel.key {
                if var scheduleEventsOnDay = scheduledEvents[key] {
                    
                    //Checks for conflict of the events in the same day
                    scheduleEventsOnDay = self.checkConflictEvents(eventViewModel: eventViewModel, scheduleEventsOnDay: scheduleEventsOnDay)
                    
                    //Sort only the events of the day
                    scheduledEvents[key] =  self.sortEventsOfTheDay(scheduleEventsOnDay: scheduleEventsOnDay)
                    
                } else {
                    var dailySchedule = [EventViewModel]()
                    dailySchedule.append(eventViewModel)
                    scheduledEvents[key] = dailySchedule
                    keys.append(key)
                }
            }
        }
        keys.sort { (a, b) -> Bool in
            return a < b
        }
        return (scheduledEvents, keys)
    }
    
    
    /* The method below check for conflict in events scheduled for the same day.
     * The time Complexity for this is O(d) which "d" is the array of evebts schedule for the same day only
     * The algorithm checks if the start date timestamp or the end date timestamp  of the
     * event being checked is inside of the start time and end time range of any event of the day.
     * with checked event = C and events of the day = D the algorith is the following:
     * (C.start > D.start) OR (C.end > D.start) And (C.end < D.end) OR (C.start < D.end)
     */
    func checkConflictEvents(eventViewModel: EventViewModel, scheduleEventsOnDay: [EventViewModel]) -> [EventViewModel] {
        var dailySchedule = scheduleEventsOnDay
        dailySchedule = dailySchedule.map({ (eventOnSchedule)  in
            
           if let eventVMTimestampStart = eventViewModel.timestampStart,
            let eventVMTimestampEnd = eventViewModel.timestampEnd,
               let eventOnScheduleTimestampStart = eventOnSchedule.timestampStart,
               let eventOnScheduleTimestampEnd = eventOnSchedule.timestampEnd ,
            
               eventVMTimestampStart > eventOnScheduleTimestampStart || eventVMTimestampEnd > eventOnScheduleTimestampStart,
               eventVMTimestampEnd < eventOnScheduleTimestampEnd ||  eventVMTimestampStart < eventOnScheduleTimestampEnd {
                   eventViewModel.isOverlaping = true
                   eventViewModel.overlappingWith = eventOnSchedule.title
                   eventOnSchedule.isOverlaping = true
                   eventOnSchedule.overlappingWith = eventViewModel.title
           }
           return eventOnSchedule
       })
       
        dailySchedule.append(eventViewModel)
        return dailySchedule
    }
    
    
    /* using Swift sorted method (Introsort algorithm) which has Time Complexity O(s log s)
    * since it is sorting only the events for each key, it is faster and worth the trade-off of avoiding using another array or recursion to sort each small chunks. So, it does keep less processing and still faster than most sorting algorithm.
    */
    private func sortEventsOfTheDay(scheduleEventsOnDay: [EventViewModel]) -> [EventViewModel] {
        return scheduleEventsOnDay.sorted(by: { (a, b) -> Bool in
            guard let eventATimestamp = a.timestampStart, let eventBTimestamp = b.timestampStart else { return false }
            return eventATimestamp < eventBTimestamp
        })
    }
}
