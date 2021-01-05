//
//  EventsListDelegate.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/9/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation

protocol EventListDelegate: class {
    func didUpdate()
    func didStartLoadingEvent()
    func didEndLoadingEvent()
    func loadEventDidFail(error: RequestError)
}
