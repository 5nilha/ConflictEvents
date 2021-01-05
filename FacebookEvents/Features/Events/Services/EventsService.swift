//
//  EventsService.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/8/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation

class EventsService {
    
    init(){}
    
    deinit {
        print("deinitializing EventsService")
    }
    
    func eventsCalendarLookup(completion: @escaping (_ result: Result<[Event], RequestError>) -> Void ) {
        RequestServiceManager.shared.request(endpoint: .events) {  (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let data):
                    do {
                        let events = try JSONDecoder().decode([Event].self, from: data)
                        completion(.success(events))
                    }
                    catch {
                        Logger.log(error: RequestError.decodedError)
                        completion(.failure(.decodedError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
