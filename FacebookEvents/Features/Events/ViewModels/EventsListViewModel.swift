//
//  EventsListViewModel.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/8/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//


import UIKit

class EventsListViewModel {
    
    private var keys = [Int]()
    private var scheduledEvents = [Int: [EventViewModel]]()
    private var manager: EventManager?
    
    init(delegate: EventListDelegate) {
        delegate.didStartLoadingEvent()
        self.manager = EventManager(delegate: delegate)
        manager?.getScheduledEvents(completion: { [weak self] (events, eventsKeys) in
            if let scheduledEvents = events, let keys = eventsKeys {
                self?.scheduledEvents = scheduledEvents
                self?.keys = keys
                delegate.didUpdate()
            }
            delegate.didEndLoadingEvent()
        })
    }
    
    deinit {
        print("deinitializing EventsListViewModel")
    }
    
    /*
    * Getting the number keys which is related to each Scheduled day
    * Time complexity of teh method is O(1)
    */
    func sectionTitleAt(section: Int) -> String?  {
       guard section < keys.count,
            let dayScheduledEvents = self.scheduledEvents[keys[section]]
            else { return nil}
        
        return dayScheduledEvents.first?.formatedDateStart
    }
    
    var sectionViewColor: UIColor {
        return UIColor(red: 0.55, green: 0.62, blue: 0.76, alpha: 1.00)
    }
    
    /*
    * Getting the number keys which is related to each Scheduled day
    * Time complexity of teh method is O(1)
    */
    var numOfDays: Int {
        return keys.count
    }
    
    
    /*
     * Getting the number of events for each day.
     * Time complexity of the method is O(5) since count in Swift is only O(1)
     * The guard conditional is used to check if the section is not out of the range,
     * and to safe unwrap to get the events for a specific key for that section
     */
    func numOfEventsOnSameDayAt(section: Int) -> Int {
        guard section < keys.count,
            let dayScheduledEvents = self.scheduledEvents[keys[section]]
            else { return 0}
        
        return dayScheduledEvents.count
    }
    
    
    /*
    * Getting the event at specific index
    * Time complexity of the method is O(9) since count in Swift is only O(1)
    * The guard conditional is used to check if the section is not out of the range,
    * and to safe unwrap to get the events for a specific key for that section
    */
    func eventAt(indexPath: IndexPath) -> EventViewModel? {
        let section = indexPath.section
        let index = indexPath.row
         guard section < keys.count,
            let dayScheduledEvents = self.scheduledEvents[keys[section]],
            index < dayScheduledEvents.count
            else { return nil}
        return dayScheduledEvents[index]
    }
    
    func backgroundForEventAt(indexPath: IndexPath) -> UIColor {
        let index = indexPath.row
        return index % 2 == 0 ? .white : UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1.00)
    }
}
