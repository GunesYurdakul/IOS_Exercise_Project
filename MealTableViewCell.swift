//
//  MealTableViewCell.swift
//  GUNES
//
//  Created by Güneş Yurdakul on 09/08/2017.
//  Copyright © 2017 gunesyurdakul. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var photoMeal: UIImageView!
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
