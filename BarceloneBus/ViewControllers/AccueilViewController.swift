//
//  AccueilViewController.swift
//  BarceloneBus
//
//  Created by Ibrahima KH GUEYE on 15/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import UIKit

class AccueilViewController: UIViewController {

    @IBOutlet weak var switchView: UISegmentedControl!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var mapvc: UIView!
    @IBOutlet weak var listViewContr: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toolBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         toolBar.isHidden = true
    }

    @IBAction func switchView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapvc.isHidden = false
            listViewContr.isHidden = true
        case 1:
            mapvc.isHidden = true
            listViewContr.isHidden = false
        default:
            break;
        }
    }
    
}
