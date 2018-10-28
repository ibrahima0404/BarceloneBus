//
//  RequestDataFromAPI.swift
//  BarceloneBus
//
//  Created by Ibrahima KH GUEYE on 11/02/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

/**
 * This class is used to retrieve data from API
 */

import Foundation

class RequestDataFromAPI: InterfaceAPI {
    private let urlString = "http://barcelonaapi.marcpous.com/bus/nearstation/latlon/41.3985182/2.1917991/1.json"
    
    private let httpInterface: HttpInterface
    
    init(httpInterface: HttpInterface = HttpSessionWrapper()) {
        self.httpInterface = httpInterface
    }
    
    func getJsonAPI(callback: @escaping InterfaceAPI.JsonAPICallback) {
        guard let url = URL(string: urlString) else {
            callback(nil)
            return
        }
        
        let request = URLRequest(url: url)
        httpInterface.makeRequest(request: request) { (data, response, error) in
            guard let jsonData = data else {
                callback(nil)
                return
            }
            
            let decoder = JSONDecoder()
            guard let json = try? decoder.decode(JsonAPI.self, from: jsonData) else {
                callback(nil)
                return
            }
            callback(json)
        }
        
    }
}

    

