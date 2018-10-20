//
//  SettingViewController.swift
//  WeatherApp
//
//  Created by Apple1 on 10/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var celciusButton: UIButton!
    @IBOutlet weak var farenheitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let isUnitChanged = UserDefaults.standard.bool(forKey: "TempUnit")

        if isUnitChanged {
            celciusButton.isSelected = true
            farenheitButton.isSelected = false

        } else {
            farenheitButton.isSelected = true
            celciusButton.isSelected = false

        }

        // Do any additional setup after loading the view.
    }

    @IBAction func changeTemperatureUnit(_ sender: UIButton) {

        if sender == celciusButton {
            celciusButton.isSelected = true
            farenheitButton.isSelected = false
            UserDefaults.standard.set(true, forKey: "TempUnit")

        } else {
            farenheitButton.isSelected = true
            celciusButton.isSelected = false
            UserDefaults.standard.set(false, forKey: "TempUnit")

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Setting"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
