//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import CoreLocation

class  WeatherClinet: NSObject {

    static let shared = WeatherClinet()
    fileprivate let apiKey = "615097af9c70b0246cbd3680be44ecaa"

    func fetchDailyForcastWeather(latValue: Double, logValue: Double, completionHandler:@escaping(_ dailyForcast: DailyForcast?, _ error: Error?) -> Void) {

        let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latValue)&lon=\(logValue)&cnt=7&appid=\(apiKey)"

        guard let url = URL(string: urlString) else {
            let error =  NSError(domain: "URL is wrong", code: 1, userInfo: nil)
            completionHandler(nil, error)
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, _, error) in

            guard error ==  nil else {
                completionHandler(nil, error)
                return
                
            }
            guard let data = data else { return}
            do {
                Utility().saveDailyForcast(data: data)
                let respose = try JSONDecoder().decode(DailyForcast.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(respose, error)
                }
            } catch let error {
                print("Error is \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func fetchCurrentCityWeather(latValue: Double, logValue: Double, completionHandler:@escaping(_ dailyForcast: CurrentForcast?, _ error: Error?) -> Void) {

         let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latValue)&lon=\(logValue)&appid=\(apiKey)"

        guard let url = URL(string: urlString) else {
            let error =  NSError(domain: "URL is wrong", code: 1, userInfo: nil)
            completionHandler(nil, error)
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, _, error) in

            guard error ==  nil else {
                completionHandler(nil, error)
                return
                
            }
            guard let data = data else { return}
            do {
                Utility().saveCurrentForcast(data: data)
                let respose = try JSONDecoder().decode(CurrentForcast.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(respose, error)
                }
            } catch let error {
                print("Error is \(error.localizedDescription)")
            }
        }
        task.resume()
    }}
