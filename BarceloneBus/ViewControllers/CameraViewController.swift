//
//  CameraViewController.swift
//  BeceloneBus
//
//  Created by Ibrahima KH GUEYE on 12/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseDatabase

/**
 * This ViewController used to access to the camera, take and save picture
 */

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var overlayView: UIView?
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var take: UIBarButtonItem!
    @IBOutlet weak var done: UIBarButtonItem!
    
    let firebaseService = FirebaseNetworkingService()
    var datePicture: String!
    var stationName: String!
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.openCamera()
        if let name = UserDefaults.standard.value(forKey: "selectedStationName") as? String {
            stationName = name
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        done.isEnabled = false
        done.tintColor = UIColor.clear
    }
    
    //MARK :  Open the camera of the device
    func openCamera() {
        imagePickerController.modalPresentationStyle = .currentContext
        imagePickerController.delegate = self
        let sourceType = UIImagePickerControllerSourceType(rawValue: 1)
        imagePickerController.sourceType = sourceType!
        
        if sourceType ==  UIImagePickerControllerSourceType.camera {
            imagePickerController.showsCameraControls = false
            imagePickerController.allowsEditing = true
            self.overlayView?.frame = (self.imagePickerController.cameraOverlayView?.frame)!
            self.imagePickerController.cameraOverlayView = self.overlayView
            self.overlayView?.backgroundColor = UIColor.clear
        }
        
        DispatchQueue.main.async {
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func validatePicture(_ sender: Any) {
        let title = titleTextView.text!
        let station = StationInfo(nameStation: stationName, titlePhoto: title, datePhoto: datePicture, image: img.image!)
       firebaseService.saveToFireBase(station: station)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func changeCam(_ sender: Any) {
        switch imagePickerController.cameraDevice {
        case .front:
            imagePickerController.cameraDevice = .rear
        case .rear:
            imagePickerController.cameraDevice = .front
        }
    }
    
    @IBAction func takeAction(_ sender: Any) {

        imagePickerController.takePicture()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK : delegate extension
extension CameraViewController {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        datePicture = dateFormatter.string(from: Date(timeIntervalSinceNow: 0))
        let image = info[UIImagePickerControllerOriginalImage]
        
        dismiss(animated: true, completion: { [weak self] in
            guard let `self` = self else {
                return
            }
            self.done.isEnabled = true
            self.done.tintColor = nil
            self.img.image = image as? UIImage
            self.titleTextView.placeholder = "Set image title"
        })
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: {
            // Done cancel dismiss of image picker.
        })
    }
}


/*
 imagePickerController.modalPresentationStyle = .currentContext
 imagePickerController.delegate = self
 let sourceType = UIImagePickerControllerSourceType(rawValue: 1)
 imagePickerController.sourceType = sourceType!
 imagePickerController.modalPresentationStyle =
 (sourceType == UIImagePickerControllerSourceType.camera) ?
 UIModalPresentationStyle.fullScreen : UIModalPresentationStyle.popover
 
 let presentationController = imagePickerController.popoverPresentationController
 //presentationController?.barButtonItem = button     // Display popover from the UIBarButtonItem as an anchor.
 presentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
 
 if sourceType == UIImagePickerControllerSourceType.camera {
 // The user wants to use the camera interface. Set up our custom overlay view for the camera.
 imagePickerController.showsCameraControls = false
 
 // Apply our overlay view containing the toolar to take pictures in various ways.
 print((imagePickerController.cameraOverlayView?.frame)!)
 self.overlayView?.frame = (self.imagePickerController.cameraOverlayView?.frame)!
 self.imagePickerController.cameraOverlayView = self.overlayView
 self.overlayView?.backgroundColor = UIColor.clear
 print((self.overlayView?.frame)!)
 }
 DispatchQueue.main.async {
 self.present(self.imagePickerController, animated: true, completion: nil)
 }
 
 
 
 // Do any additional setup after loading the view.*/
