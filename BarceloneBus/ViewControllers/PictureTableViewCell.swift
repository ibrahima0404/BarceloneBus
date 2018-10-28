//
//  PictureTableViewCell.swift
//  BeceloneBus
//
//  Created by Ibrahima KH GUEYE on 13/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import UIKit

/**
 * The custome cell of the bus station pictures tableVC
 */

class PictureTableViewCell: UITableViewCell {
    static let Identifier = "Cell"
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var imageDate: UILabel!
    
    func configureWith(stationInfo: StationInfo) {
        cellImage.image = stationInfo.image
        imageName.text = stationInfo.titlePhoto
        imageDate.text = stationInfo.datePhoto
    }
}
