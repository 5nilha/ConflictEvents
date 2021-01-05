//
//  RequestServiceManager.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/8/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import Foundation
enum RequestEndpoint: String {
    case events = "EventsMock"
}

class RequestServiceManager {
    
    static let shared = RequestServiceManager()
    
    init() {}
    
    
    /*
     * The request is has only one concern which is to fetch the data from file in the path
     */
    func request(endpoint: RequestEndpoint, completion: @escaping (_ result: Result<Data, RequestError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let path = Bundle.main.path(forResource: endpoint.rawValue, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                     completion(.success(data))
                  } catch {
                    Logger.log(error: RequestError.fileNotFound)
                    completion(.failure(.fileNotFound))
                  }
            } else {
                Logger.log(error: RequestError.wrongPath)
                completion(.failure(.wrongPath))
            }
        }
    }
}
