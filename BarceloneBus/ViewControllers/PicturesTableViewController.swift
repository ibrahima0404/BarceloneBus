//
//  PicturesTableViewController.swift
//  BeceloneBus
//
//  Created by Ibrahima KH GUEYE on 13/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import RxCocoa
import RxSwift
/**
 * This TableViewController shows all pictures taken near a bus station
 */

class PicturesTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pictureTableViewCellDidTapImage(_ sender: PictureTableViewCell) {
        print("Yup")
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet var overlayView: UIView!
    var arrayStation = [StationInfo]()
     var rxstationArray: Observable<[StationInfo]> = Observable.just([StationInfo]())
    var arrayImage = [UIImage]()
    var navTitle: String!
    var imagePickerController = UIImagePickerController()
    var databaseRef: DatabaseReference!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference().child("allPictures")
        databaseRef.observe(.value, with: { (snapshot) in
            self.tableView.delegate = nil
            self.tableView.dataSource = nil
            var newItems = [StationInfo]()
            for item in snapshot.children {
            let newStationInfo = StationInfo(snapshot: item as! DataSnapshot)
                if newStationInfo.nameStation == self.navTitle {
                   newItems.insert(newStationInfo, at: 0)
                }
                
            }
            self.arrayStation = newItems
            self.rxstationArray = Observable.just(self.arrayStation)
            DispatchQueue.main.async {
                self.arrayStation = newItems
                self.spinner.stopAnimating()
                self.setUpCellConfiguration()
                self.setUpCellHandling()
                self.setUpCellHandling3()
               
            }
        }) { (error) in
            print("Error: \(error.localizedDescription)")
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
      
        navTitle = UserDefaults.standard.value(forKey: "selectedStationName") as? String
           self.navigationItem.title = navTitle
         UIApplication.shared.isStatusBarHidden = true
    }
    
    
    @IBAction func takePicture(_ sender: Any) {
    }
    
    @IBAction func addPicture(_ sender: Any) {
      
    }
    

    @objc func selectPicture(tapGestureRecognizer: UITapGestureRecognizer) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVc") as! PictureViewController
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        vc.img = tappedImage.image
        self.navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue2" {
            let vc: CameraViewController = segue.destination as! CameraViewController
            vc.stationName = self.navigationItem.title
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            let ref = arrayStation[indexPath.row].ref
            ref?.removeValue()
            arrayStation.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension PicturesTableViewController {
    private func setUpCellConfiguration() {
        self.rxstationArray.bind(to: self.tableView
            .rx
            .items) {( tableView,
                row, stationInfo) in
                 let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: IndexPath(row: row, section: 1)) as! PictureTableViewCell
                cell.configureWith(stationInfo: self.arrayStation[row])
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.selectPicture(tapGestureRecognizer:)))
                tapGestureRecognizer.numberOfTapsRequired = 1
                cell.cellImage.isUserInteractionEnabled = true
                cell.cellImage.addGestureRecognizer(tapGestureRecognizer)
                return cell
        }
        
            .disposed(by: disposeBag)
    }
    
    private func setUpCellHandling() {
        self.tableView
            .rx
            .modelSelected(StationInfo.self)
            .subscribe(onNext: {stationInfo in
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpCellHandling1() {
        self.tableView
            .rx
            .itemSelected
            .subscribe(onNext: {[weak self]
                indexPath in
                if let cell = self?.tableView.cellForRow(at: indexPath) {
                    cell.textLabel?.text = "RxSwift is Special"
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpCellHandling3() {
        self.tableView
            .rx
            .itemDeleted
            .subscribe(onNext: {[weak self]
                indexPath in
                let ref = self?.arrayStation[indexPath.row].ref
                ref?.removeValue()
                self?.tableView.delegate = nil
                self?.tableView.dataSource = nil
            })
            .disposed(by: disposeBag)
    }
    
    private func setDelegate() {
        self.tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
    }
}


