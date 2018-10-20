//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Apple1 on 10/19/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct CurrentForcast: Decodable {
    var base: String?
    var visibility: Int?
    var dt: Date?
    var id: Int64?
    var name: String? = ""
    var cod: Int?
    var coord: LocationCoordinate?
    var weather: [Weather]?
    var main: Main?
    var wind: Wind?
    var clouds: Clouds?
    var sys: Sys?
}

struct LocationCoordinate: Decodable {
    var lon: Double?
    var lat: Double?

}

struct Main: Decodable {
    var temp: Double?
    var pressure: Double?
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
}
struct Wind: Decodable {
    var speed: Double?
    var deg: Double?
}
struct Clouds: Decodable {
    var all: Double?
}
struct Sys: Decodable {
    var type: Int?
    var id: Int?
    var message: Double?
    var country: String?
    var sunrise: Date?
    var sunset: Date?
}
