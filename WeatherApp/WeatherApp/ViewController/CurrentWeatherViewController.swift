//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import CoreLocation
import Shimmer
import DZNEmptyDataSet



class CurrentWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    // MARK: -  🏢 IBOutlets and Variables

    @IBOutlet weak var tableView: UITableView!

    var currentForcast: CurrentForcast?
    var latitude: Double?
    var longitude: Double?
    var isDataLoading: Bool = true

    let locationManager = CLLocationManager()
    
    // MARK: - 🌻 Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        self.tableView.tableFooterView = UIView()
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            self.locationManager.requestLocation()

        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {

        let unitChanged = UserDefaults.standard.bool(forKey: "TempUnit")
        print("unitChange \(unitChanged)")
        self.tableView.reloadData()
        self.title = "Current Forcast"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
        
    }

    
    
    // MARK: - 🚧 Local Class Methods
    
    func setupNetworking() {
        
        NetworkManager.isReachable { _ in
        //self.locationManager.requestLocation()
            
        }
        NetworkManager.sharedInstance.reachability.whenUnreachable = { reachability in
        BPStatusBarAlert().bgColor(color: .orange).message(message: "Network not reachable").show()
            
        }
        NetworkManager.isUnreachable { _ in
        BPStatusBarAlert().bgColor(color: .orange).message(message: "Network not reachable").show()
        }
        
        NetworkManager.sharedInstance.reachability.whenReachable = { reachability in
           // self.locationManager.requestLocation()
            BPStatusBarAlert().bgColor(color: .green).message(message: "Network is reachable").show()
            
        }
    }
    func loadCurrentForcast() {

        WeatherClinet.shared.fetchCurrentCityWeather(latValue: latitude ?? 25.2048, logValue: longitude ?? 55.2708) { (currentForcastResult, error) in

            if let error = error {
                print("Error:\(error.localizedDescription)")
                // When Net is offline then read saved Data
                if let savedCurrentForcast = Utility().getCurrentForcastData() {
                    self.currentForcast = savedCurrentForcast
                    DispatchQueue.main.async {
                        self.isDataLoading = false
                        self.tableView.reloadData()
                        }
                }
                return
            }
            self.currentForcast = currentForcastResult
            DispatchQueue.main.async {
                self.isDataLoading = false
                self.tableView.reloadData()

            }
        }
    }
    
    // MARK: - 🏁 Protocols Conformance
    // MARK: - UITableView Delegates and DataSources

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if isDataLoading {
            return 150
        }
        if indexPath.row == 0 {
            return 150
        }
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDataLoading {
            return 1
        }
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isDataLoading {
            let cell: LoadingCell = (self.tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell)!
            cell.shimeringView.contentView = cell.itemsView
            cell.shimeringView.isShimmering = true
            return cell
        }
        else {
        
        if indexPath.row == 0 {
            let cell: CurrentWeatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! CurrentWeatherCell
            cell.populateData(currentForcast: currentForcast)
            return cell

        } else {
            let cell: CurrentWeatherDetailCell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! CurrentWeatherDetailCell
            cell.populateData(currentForcast: currentForcast, indexPath: indexPath as NSIndexPath)
            return cell
        }
    }
    }

    @IBAction func refreshData(_ sender: Any) {
        self.isDataLoading = true
        self.tableView.reloadData()
        locationManager.requestLocation()
        }

}


// MARK: -  🔀 Class Extension
// MARK: - 🕹Location Manager Delegates
extension CurrentWeatherViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
                if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
                    latitude = Double(lat)
                    longitude = Double(long)
                    loadCurrentForcast()
                    
                }
                else {
                    print("ErroUser r location cannot de detected")
                }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Error \(error.localizedDescription)")

    }
}
