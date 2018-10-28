//
//  HttpSessionWrapper.swift
//  BarceloneBus
//
//  Created by Ibrahima KH GUEYE on 11/02/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

/**
 * Wrapper of URLSession
 */


import Foundation

class HttpSessionWrapper: HttpInterface {
    func makeRequest(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: callback)
        task.resume()
    }
}
