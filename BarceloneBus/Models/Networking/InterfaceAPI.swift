//
//  InterfaceAPI.swift
//  BarceloneBus
//
//  Created by Ibrahima KH GUEYE on 11/02/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import Foundation


struct Station: Codable {
    let id: String
    let street_name: String
    let city: String
    let utm_x: String
    let utm_y: String
    let lat: String
    let lon: String
    let furniture: String
    let buses: String
    let distance: String
}

struct JsonData: Codable {
    let nearstations: [Station]
}

struct JsonAPI: Codable {
    let code: Int
    let data: JsonData
}

protocol InterfaceAPI {
    /// A callback for retrieving a list of story IDs
    typealias JsonAPICallback = ((JsonAPI?) -> Void)
    func getJsonAPI(callback: @escaping JsonAPICallback)
}
