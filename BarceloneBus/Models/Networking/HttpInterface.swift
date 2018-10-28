//
//  HttpInterface.swift
//  BarceloneBus
//
//  Created by Ibrahima KH GUEYE on 11/02/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import Foundation

protocol HttpInterface {
    /// Make a network request asynchronously
    func makeRequest(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
}
