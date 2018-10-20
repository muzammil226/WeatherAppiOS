//
//  Extension.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import DZNEmptyDataSet
import Reachability


extension Date {

    func forcastDate() -> String {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d"
        let date = df.string(from: self)
        return date
    }
    func forcastTime() -> String {
        let df = DateFormatter()
        df.dateFormat = "HH:mm a"
        let date = df.string(from: self)
        return date
    }
}

extension Double {

    func toDisplayUnit() -> String {

        let isUnitChange = UserDefaults.standard.bool(forKey: "TempUnit")
            if isUnitChange {
                let celsiusTemp = self - 273.15
                let celcisuString = String(format: "%.0f", celsiusTemp)
                return "+" + celcisuString + " °C"
            } else {
                let farenheitTemp = 1.8 * (self - 273.15) + 32
                let farenheitString = String(format: "%.0f", farenheitTemp)
                return "+" + farenheitString + " °F"
            }
    }
}


// MARK: - CurrentViewController Class Extension

extension CurrentWeatherViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No weather forcast found!"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Please check your internet connection."
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "taylor-swift")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        let str = "Tap to refresh Data"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.loadCurrentForcast()
    }
}

// MARK: - DailyForcasrViewController Class Extension

extension DailyForecastViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Daily forcast found!"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline),NSAttributedString.Key.foregroundColor : UIColor.white]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Please check your internet connection."
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body),    NSAttributedString.Key.foregroundColor : UIColor.white]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "taylor-swift")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        let str = "Tap to refresh Data"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout),NSAttributedString.Key.foregroundColor : UIColor.white]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.loadDailyForcast()
    }
}
