//
//  Event.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/8/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation

class Event: Decodable {
    
    public private (set) var id: String?
    public private (set) var title: String?
    public private (set) var start: String?
    public private (set) var end: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case start
        case end
    }
    
    init(title: String, start: String, end: String) {
        self.title = title
        self.start = start
        self.end = end
        self.id = UUID().uuidString
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.start = try container.decodeIfPresent(String.self, forKey: .start)
        self.end = try container.decodeIfPresent(String.self, forKey: .end)
        self.id = UUID().uuidString
    }
    
    deinit {
         print("deinitializing event for \(String(describing: title))")
    }
}
