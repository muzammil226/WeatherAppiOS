//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import LGSideMenuController
import CoreLocation

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    var latitude: Double?
    var longitude: Double?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let nav: UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        let menu: LeftViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController

        let slidingMenuRoot: LGSideMenuController = LGSideMenuController(rootViewController: nav, leftViewController: menu, rightViewController: nil)
        slidingMenuRoot.leftViewWidth = 250.0
        slidingMenuRoot.leftViewPresentationStyle = .scaleFromLittle
        slidingMenuRoot.leftViewBackgroundImage = UIImage(named: "menu-bg")

        let window = UIApplication.shared.delegate!.window!!
        window.rootViewController = slidingMenuRoot

        // Make Setting true for Celcius Degree
        UserDefaults.standard.set(true, forKey: "TempUnit")
        
        // Setting Background Fetch in the app
        
//        self.locationManager.requestAlwaysAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
//            locationManager.requestLocation()
//        }
        
        //UIApplication.shared.setMinimumBackgroundFetchInterval(10)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//
//        locationManager.requestLocation()
//    }
    

}

//extension AppDelegate:CLLocationManagerDelegate{
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
//            print("Last locations = \(lat) \(long)")
//            latitude = Double(lat)
//            longitude = Double(long)
//            print("Last to Double locations = \(latitude ?? 0) \(longitude ?? 0)")
//
//
//        }
//        else {
//            print("ErroUser r location cannot de detected")
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//
//        print("Error \(error.localizedDescription)")
//
//    }
//}
