//
//  StationInfo.swift
//  BeceloneBus
//
//  Created by Ibrahima KH GUEYE on 11/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase
import RxCocoa
import RxSwift

struct StationInfo {
    var nameStation: String!
    var titlePhoto: String!
    var datePhoto: String!
    var strPhoto: String!
    var image: UIImage?
    var ref: DatabaseReference?
    var key: String!
    
    var databaseRef: DatabaseReference {
        return Database.database().reference()
    }
    
    init(nameStation: String, titlePhoto: String, datePhoto: String, image: UIImage, key: String = "") {
        self.nameStation = nameStation
        self.titlePhoto = titlePhoto
        self.datePhoto = datePhoto
        self.image = image
        self.key = key
        self.ref = Database.database().reference()
        
        
    }
    
    init(snapshot: DataSnapshot) {
        let dict = (snapshot.value as? NSDictionary)!
        self.nameStation = dict["nameStation"] as? String
        self.titlePhoto = dict["titlePhoto"] as? String
        self.datePhoto = dict["datePhoto"] as? String
        self.key = snapshot.key
        self.ref = snapshot.ref
        self.strPhoto = dict["strPhoto"] as? String
        let data = Data(base64Encoded: self.strPhoto)
        self.image = UIImage(data: data!)
        
    }
  
}
