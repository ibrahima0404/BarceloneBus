//
//  FirebaseNetworkingService.swift
//  BeceloneBus
//
//  Created by Ibrahima KH GUEYE on 13/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

/**
 * Struct for firebase service
 */


import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage

struct FirebaseNetworkingService {
    var databaseRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference {
        return Storage.storage().reference()
    }
    
    func saveToFireBase(station: StationInfo) {
        let data = UIImageJPEGRepresentation(station.image!, 0.8)
        let str = data?.base64EncodedString()
        let newPicture = ["nameStation": station.nameStation!, "titlePhoto": station.titlePhoto, "datePhoto": station.datePhoto, "strPhoto": str]
        let newElement = databaseRef.child("allPictures").childByAutoId()
        newElement.setValue(newPicture)
        
    }

}

