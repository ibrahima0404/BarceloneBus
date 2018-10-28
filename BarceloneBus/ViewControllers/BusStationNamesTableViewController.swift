//
//  BusStationNamesTableViewController.swift
//  BeceloneBus
//
//  Created by Ibrahima KH GUEYE on 10/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

/**
 * This TableViewController shows all bus station name
 * I use RxSwift to make it most reactive
 */

import UIKit
import RxCocoa
import RxSwift

class BusStationNamesTableViewController: UITableViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var stationArray = [Station]()
    var rxstationArray: Observable<[Station]> = Observable.just([Station]())
    var selectedStationName: String!
    let reqApi = RequestDataFromAPI()
    let disposeBag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont.preferredFont(forTextStyle: .title1)]
        reqApi.getJsonAPI {  (jsonApi) in
            if jsonApi == nil {
                print("Error in getJsonAPI")
            }
            self.stationArray = (jsonApi?.data.nearstations)!
            self.rxstationArray = Observable.just(self.stationArray)
            DispatchQueue.main.async {
                self.setUpCellConfiguration()
                self.setUpCellHandling()
                self.spinner.stopAnimating()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rect = self.navigationController?.navigationBar.frame
        let y = rect!.size.height + rect!.origin.y
        self.tableView.contentInset = UIEdgeInsetsMake(y+y/2, 0, 0, 0);

    }

}

//MARK : RxSwift extension
extension BusStationNamesTableViewController {
    
    private func setUpCellConfiguration() {
        self.rxstationArray.bind(to: self.tableView
            .rx
            .items(cellIdentifier: "cell")) {
                row, station, cell in cell.textLabel?.text = station.street_name
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpCellHandling() {
        self.tableView
            .rx
            .modelSelected(Station.self)
            .subscribe(onNext: {station in
                print(station.buses)
                self.selectedStationName = station.street_name
                UserDefaults.standard.setValue(self.selectedStationName, forKey: "selectedStationName")
                UserDefaults.standard.synchronize()
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

}
