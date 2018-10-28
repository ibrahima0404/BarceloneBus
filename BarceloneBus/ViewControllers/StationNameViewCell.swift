//
//  StationNameViewCell.swift
//  BarceloneBus
//
//  Created by Ibrahima KH GUEYE on 24/02/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import UIKit

/**
 * The custome cell of the bus station names tableVC 
 */

class StationNameViewCell: UITableViewCell {
    static let Identifier = "Cell"

    @IBOutlet weak var cellTitle: UILabel!
    func configureWith(busStations: BusStations) {
        cellTitle.text = busStations.name
       
    }
}
