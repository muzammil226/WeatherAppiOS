//
//  LeftViewController.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var menuItem = ["Current Forcast", "Daily Forcast", "Setting"]
    var menuIcons = ["current_forcast", "daily_forcast", "settings"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }

    // MARK: - UITableView Delegates and Data Soruce

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: LeftMenuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! LeftMenuCell
        cell.menuLabel.text = menuItem[indexPath.row]
        if let image = UIImage(named:menuIcons[indexPath.row]) {
            let tintableImage = image.withRenderingMode(.alwaysTemplate)
            cell.menuIcon.image = tintableImage
            cell.tintColor = UIColor.white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let mainViewController = sideMenuController!
        mainViewController.isLeftViewSwipeGestureEnabled = false
        let viewController: UIViewController!
        let navController: UINavigationController = mainViewController.rootViewController as! UINavigationController
        switch indexPath.row {
        case 0:
        mainViewController.hideLeftView(animated: true, completionHandler: nil)

        case 1:
            viewController = self.storyboard!.instantiateViewController(withIdentifier: "DailyForecastViewController")
            navController.pushViewController(viewController, animated: true)
            mainViewController.hideLeftView(animated: true, completionHandler: nil)

        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController")
            navController.pushViewController(viewController, animated: true)
            mainViewController.hideLeftView(animated: true, completionHandler: nil)

        default:
            break
        }
    }

}
