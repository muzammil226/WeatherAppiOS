//
//  CurrentWeatherDetailCell.swift
//  WeatherApp
//
//  Created by Apple1 on 10/19/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class CurrentWeatherDetailCell: UITableViewCell {

    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var weatherDetailIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func populateData(currentForcast: CurrentForcast?, indexPath: NSIndexPath) {

        switch indexPath.row {
        case 1:
            self.weatherDetailLabel?.text = " Wind: \(currentForcast?.wind?.speed ?? 0) m/s"
            self.weatherDetailIcon.image = UIImage(named: "wind")

            if let image = UIImage(named: "wind") {
                let tintableImage = image.withRenderingMode(.alwaysTemplate)
                self.weatherDetailIcon.image = tintableImage
                self.tintColor = UIColor.white
            }

        case 2:
            self.weatherDetailLabel?.text = " Humidity: \(currentForcast?.main?.humidity ?? 0) %"
            self.weatherDetailIcon.image = UIImage(named: "humidity")
            if let image = UIImage(named: "humidity") {
                let tintableImage = image.withRenderingMode(.alwaysTemplate)
                self.weatherDetailIcon.image = tintableImage
                self.tintColor = UIColor.white
            }
        case 3:
            self.weatherDetailLabel?.text = " Pressure: \(currentForcast?.main?.pressure ?? 0) hpa"
            self.weatherDetailIcon.image = UIImage(named: "pressure")
            if let image = UIImage(named: "pressure") {
                let tintableImage = image.withRenderingMode(.alwaysTemplate)
                self.weatherDetailIcon.image = tintableImage
                self.tintColor = UIColor.white
            }
        case 4:
            self.weatherDetailLabel?.text = " Cloudness: \(currentForcast?.clouds?.all ?? 0) %"
            self.weatherDetailIcon.image = UIImage(named: "cloudness")
            if let image = UIImage(named: "cloudness") {
                let tintableImage = image.withRenderingMode(.alwaysTemplate)
                self.weatherDetailIcon.image = tintableImage
                self.tintColor = UIColor.white
            }

        case 5:
            if let sunrise = currentForcast?.sys?.sunrise {
                self.weatherDetailLabel?.text = " Sunrise: " + sunrise.forcastTime()
                self.weatherDetailIcon.image = UIImage(named: "sunrise")
                if let image = UIImage(named: "sunrise") {
                    let tintableImage = image.withRenderingMode(.alwaysTemplate)
                    self.weatherDetailIcon.image = tintableImage
                    self.tintColor = UIColor.white
                }

            }

        case 6:
            if let sunset = currentForcast?.sys?.sunset {
                self.weatherDetailLabel?.text = " Sunrise: " + sunset.forcastTime()
                self.weatherDetailIcon.image = UIImage(named: "sunset")
                if let image = UIImage(named: "sunset") {
                    let tintableImage = image.withRenderingMode(.alwaysTemplate)
                    self.weatherDetailIcon.image = tintableImage
                    self.tintColor = UIColor.white
                }

            }

        default:
            break
        }
    }

}
