//
//  CurrentWeatherCell.swift
//  WeatherApp
//
//  Created by Apple1 on 10/19/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populateData(currentForcast: CurrentForcast?) {

        if let currentWeatherForcast = currentForcast {

            //let unitChange = UserDefaults.standard.bool(forKey:"TempUnit")

            let location = currentWeatherForcast.name ?? ""
            let country = currentWeatherForcast.sys?.country?.uppercased() ?? ""

            self.locationLabel.text = location + " " + country
            self.tempLabel.text =  currentWeatherForcast.main?.temp?.toDisplayUnit()
            if let weatherInfo = currentWeatherForcast.weather?[0] {
            self.weatherIcon.image = UIImage(named: weatherInfo.icon ?? "0id")
                self.descriptionLabel.text = weatherInfo.description ?? ""

        }
    }
}
}
