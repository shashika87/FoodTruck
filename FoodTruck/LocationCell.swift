//
//  LocationCell.swift
//  FoodTruck
//
//  Created by Shashi Kant on 1/28/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    @IBOutlet weak var menuLabel: UILabel?
    @IBOutlet weak var hoursLabel: UILabel?
    @IBOutlet weak  var constraintMenuHeight: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.menuLabel?.numberOfLines = 0;
        self.nameLabel?.numberOfLines=0
        self.nameLabel?.sizeToFit()
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
