//
//  CustomCell.swift
//  FoodTracker
//
//  Created by Hung Nguyen on 7/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealImage: ImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
