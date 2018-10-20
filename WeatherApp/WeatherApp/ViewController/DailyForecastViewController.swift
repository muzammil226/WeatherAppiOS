//
//  ViewController.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import CoreLocation
import Shimmer
import DZNEmptyDataSet


class DailyForecastViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: -  🏢 IBOutlets and Variables

    @IBOutlet weak var tableView: UITableView!
    var dailyForcast: DailyForcast?
    var latitude: Double?
    var longitude: Double?

    var isDataLoading: Bool = true
    let locationManager = CLLocationManager()

    // MARK: - 🌻 Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.locationManager.requestAlwaysAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            self.locationManager.requestLocation()
        }
        self.title = "Daily Forcast"
}
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
        
    }

    // MARK: - 🚧 Local Class Methods
    
    func setupNetworking() {
        
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        }
        
        NetworkManager.isReachable { _ in
            
            self.locationManager.requestLocation()
            
        }
        NetworkManager.sharedInstance.reachability.whenUnreachable = { reachability in
            self.locationManager.requestLocation()
            BPStatusBarAlert().bgColor(color: .orange).message(message: "Network not reachable").show()
            
        }
        NetworkManager.isUnreachable { _ in
        BPStatusBarAlert().bgColor(color: .orange).message(message: "Network not reachable").show()
        }
        
        NetworkManager.sharedInstance.reachability.whenReachable = { reachability in
            self.locationManager.requestLocation()
            BPStatusBarAlert().bgColor(color: .green).message(message: "Network is reachable").show()
            
        }
    }
    func loadDailyForcast() {

        WeatherClinet.shared.fetchDailyForcastWeather(latValue:latitude ?? 25.2048, logValue:longitude ?? 55.2708) { (dailyForcastResult, error) in

            if let error = error {
                print("Error:\(error.localizedDescription)")
                if let savedDailyForcast = Utility().getDailyForcastData() {
                    self.dailyForcast = savedDailyForcast

                    DispatchQueue.main.async {
                        self.isDataLoading = false
                        self.tableView.reloadData()
                        
                    }
                }
                return
            }
            self.isDataLoading = false
            self.dailyForcast = dailyForcastResult
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
    }


    // MARK: - 🏁 Protocols Conformance
    
    // MARK: - 🕹Location Manager Delegates

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            latitude = Double(lat)
            longitude = Double(long)
            print("Last locations = \(lat) \(long)")
            print("Last to Double locations = \(latitude ?? 0) \(longitude ?? 0)")
            loadDailyForcast()
            
        }
        else {
            print("ErroUser r location cannot de detected")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Error \(error.localizedDescription)")
        
    }

    // MARK: - UITableView Delegates and DataSources
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDataLoading {
            return 2
        }
        else {
            return dailyForcast?.list.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isDataLoading {
            let cell: LoadingCell = (self.tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell)!
            cell.shimeringView.contentView = cell.itemsView
            cell.shimeringView.isShimmering = true
            
            return cell
        }
        else {
        let cell: DailyForcastCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!DailyForcastCell
        let forcast = dailyForcast?.list[indexPath.row]
        cell.populateData(dailyForcastList: forcast)
        return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailView.dailyForcast = dailyForcast?.list[indexPath.row]
            self.navigationController?.pushViewController(detailView, animated: true)
    }
}

