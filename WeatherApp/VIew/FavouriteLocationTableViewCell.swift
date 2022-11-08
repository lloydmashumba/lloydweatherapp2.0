//
//  FavouriteLocationTableViewCell.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 8/11/2022.
//

import UIKit

class FavouriteLocationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var city_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
