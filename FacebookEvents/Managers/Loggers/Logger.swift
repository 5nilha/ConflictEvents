//
//  Logger.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/9/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation


class Logger {
    
    class func log(error: RequestError) {
        let errorDescription = error.description
        let errorTitle = error.title
        let errorTimestamp = Date().timeIntervalSince1970
        
        let errorLog = [
            errorTimestamp: [
                "title" : errorTitle,
                "description" : errorDescription,
                "errorDate" : errorTimestamp
            ]]
        
        print(errorLog)
    }
}
