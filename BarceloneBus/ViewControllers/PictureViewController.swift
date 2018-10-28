//
//  PictureViewController.swift
//  BeceloneBus
//
//  Created by Ibrahima KH GUEYE on 13/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var img: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        defaults.string(forKey: "userNameKey")
        imageView.image = img//UIImage(named: "placeholder.jpeg")
    }

    @IBAction func actionTodo(_ sender: Any) {
        let shareImage = imageView.image
        let vc = UIActivityViewController(activityItems: [shareImage!], applicationActivities: [])
        vc.excludedActivityTypes =  [
            UIActivityType.airDrop,
            UIActivityType.assignToContact,
            UIActivityType.addToReadingList,
            //UIActivityType.copyToPasteboard,
            //UIActivityType.mail,
            //UIActivityType.message,
            //UIActivityType.openInIBooks,
            //UIActivityType.postToFacebook,
            //UIActivityType.postToFlickr,
            UIActivityType.postToTencentWeibo,
            //UIActivityType.postToTwitter,
            UIActivityType.postToVimeo,
            UIActivityType.postToWeibo,
            UIActivityType.print,
            //UIActivityType.saveToCameraRoll
        ]
        present(vc, animated: true, completion: nil)
        vc.popoverPresentationController?.sourceView = self.view
        vc.completionWithItemsHandler = {(activity, success, items, error) in
        }
    }
    

}
