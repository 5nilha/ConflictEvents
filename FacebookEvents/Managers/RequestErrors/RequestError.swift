//
//  RequestError.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/8/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case wrongPath
    case fileNotFound
    case decodedError
    
    var title: String {
        return "Loading Event Error"
    }
    
    var UIDescription: String {
        return "Something went wrong! \nWe are unable to retrieve your events at the moment."
    }
    
    var description: String {
        switch self {
        case .decodedError:
            return "Error trying to decode data"
        case .fileNotFound:
            return "Error of File not found"
        case .wrongPath:
            return "Error with the file path wrong"
        }
    }
}
