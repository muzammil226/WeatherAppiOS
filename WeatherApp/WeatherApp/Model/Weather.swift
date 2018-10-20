//
//  Weather.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

// MARK: - DailyForcast Data Model
struct DailyForcast: Decodable {

    var cod: String?
    var message: Double
    var cnt: Int?
    var list: [List] = []
    var city: City?

}
struct City: Decodable {

    var id: Int64?
    var name: String?
    var country: String?
    var population: Int?
    var coord: Coordinate?

}

struct Coordinate: Decodable {
    var lon: Double
    var lat: Double
}

struct List: Decodable {

    var dt: Date?
    var pressure: Double?
    var humidity: Double?
    var speed: Double?
    var deg: Double?
    var clouds: Double?
    var temp: Temperature?
    var weather: [Weather]?

}
struct Temperature: Decodable {

    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
}

struct Weather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
