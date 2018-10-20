//
//  LoadingCell.swift
//  WeatherApp
//
//  Created by Apple1 on 10/20/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Shimmer


class LoadingCell: UITableViewCell {

    @IBOutlet weak var shimeringView: FBShimmeringView!
    @IBOutlet weak var itemsView: UIView!
    @IBOutlet weak var iconView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.iconView.layer.cornerRadius = self.iconView.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
