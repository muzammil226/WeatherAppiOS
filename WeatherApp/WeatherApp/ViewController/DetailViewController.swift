//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var eveningLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    var dailyForcast: List?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let weather = dailyForcast?.weather?[0] {
            self.weatherDetailLabel.text = weather.description?.uppercased()
        }

        if let morning = dailyForcast?.temp?.morn?.toDisplayUnit() {
            self.morningLabel.text = "Morning \n" + morning
        }
        if let evening = dailyForcast?.temp?.eve?.toDisplayUnit() {
            self.eveningLabel.text = "Evennig \n" + evening
        }
        if let night = dailyForcast?.temp?.night?.toDisplayUnit() {
            self.nightLabel.text = "Night \n" + night
        }
        if let day = dailyForcast?.temp?.day?.toDisplayUnit() {
            self.dayLabel.text = "Day \n" + day
        }

        self.windLabel.text = " Wind \(dailyForcast?.speed ?? 0) m/s NW"
        self.humidityLabel.text = "Humidity \(dailyForcast?.humidity ?? 0) %"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Detail Forcast"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }

    

    // MARK: - class Methods

}
