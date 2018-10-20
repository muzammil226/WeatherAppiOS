//
//  DailyForcastCell.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class DailyForcastCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populateData(dailyForcastList: List?) {

        self.dayLabel.text = dailyForcastList?.dt?.forcastDate()
        self.minTempLabel.text =  dailyForcastList?.temp?.min?.toDisplayUnit()
        self.maxTempLabel.text = dailyForcastList?.temp?.max?.toDisplayUnit()
        if let weatherIcon = dailyForcastList?.weather?[0] {
            self.weatherIcon.image = UIImage(named: weatherIcon.icon ?? "0id")
        }
    }
}
