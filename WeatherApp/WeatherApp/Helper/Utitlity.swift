//
//  Utitlity.swift
//  WeatherApp
//
//  Created by Apple1 on 10/20/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class Utility {

//    func saveCurrentForcast(data:Data?){
//
//        let dataFilename = "ForcastData"
//        let fullPath = getDocumentsDirectory().appendingPathComponent(dataFilename)
//
//        do {
//
//            try data?.write(to: fullPath)
//            print("Data saved Successfully on file")
//            } catch {
//            print("Couldn't write file")
//        }
//    }
//    func getCurrentForcastData() -> CurrentForcast?{
//        let dataFilename = "ForcastData"
//        let fullPath = getDocumentsDirectory().appendingPathComponent(dataFilename)
//        do{
//
//        let weatherData = try NSData(contentsOf: fullPath, options: NSData.ReadingOptions())
//            print(weatherData)
//            let respose = try JSONDecoder().decode(CurrentForcast.self, from: weatherData as Data)
//            print(respose)
//        }
//
//        catch{
//            print("Couldn't write file")
//
//        }
//        return nil
//
//    }
//
//        func getDocumentsDirectory() -> URL {
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            return paths[0]
//        }
//
//        func saveDailyForcast(data:Data?){
//
//            let dataFilename = "ForcastData"
//            let fullPath = getDocumentsDirectory().appendingPathComponent(dataFilename)
//
//            do {
//
//                try data?.write(to: fullPath)
//                print("Data saved Successfully on file")
//            } catch {
//                print("Couldn't write file")
//            }
//        }
//        func getDailyForcastData() -> DailyForcast? {
//
//            let dataFilename = "DailyForcastData"
//            let fullPath = getDocumentsDirectory().appendingPathComponent(dataFilename)
//            do{
//
//                let weatherData = try NSData(contentsOf: fullPath, options: NSData.ReadingOptions())
//                print(weatherData)
//                let respose = try JSONDecoder().decode(DailyForcast.self, from: weatherData as Data)
//                print(respose)
//            }
//
//            catch{
//                print("Couldn't write file")
//
//            }
//            return nil
//        }
    
    
    var filePathCurrentForcast: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        //print("this is the url path in the documentDirectory \(url)")
        return (url!.appendingPathComponent("CurrentForcastData").path)
    }
    
    func saveCurrentForcast(data: Data?) {
        if let unsavedData = data{
            NSKeyedArchiver.archiveRootObject(unsavedData, toFile: filePathCurrentForcast)
            print("Current forcast Data saved Successfully on file")
        }
    }
    
    func getCurrentForcastData() ->CurrentForcast? {
        if let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: filePathCurrentForcast) as? Data {
            print("Saved Data:\(savedData)")
            
            do {
                let respose = try JSONDecoder().decode(CurrentForcast.self, from: savedData)
                return respose
                
            } catch let error {
                print("Error is \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    var filePathDailyForcast: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        //print("this is the url path in the documentDirectory \(url)")
        return (url!.appendingPathComponent("DailyForcastData").path)
    }
    
    func saveDailyForcast(data: Data?) {
        if let unsavedData = data{
            NSKeyedArchiver.archiveRootObject(unsavedData, toFile: filePathDailyForcast)
            print("DailyForcast Data saved Successfully on file")
        }
    }
    
    func getDailyForcastData() ->DailyForcast? {
        if let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: filePathDailyForcast) as? Data {
            print("Saved Data:\(savedData)")
            
            do {
                let respose = try JSONDecoder().decode(DailyForcast.self, from: savedData)
                return respose
                
            } catch let error {
                print("Error is \(error.localizedDescription)")
            }
        }
        return nil
    }
}

    

    


