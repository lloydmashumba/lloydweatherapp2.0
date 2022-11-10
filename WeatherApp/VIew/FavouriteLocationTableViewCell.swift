//
//  FavouriteLocationTableViewCell.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 8/11/2022.
//

import UIKit

class FavouriteLocationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var coord: UILabel!
    @IBOutlet weak var city_name: UILabel!
    
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        descriptionContainerView.layer.cornerRadius = 8
        descriptionContainerView.backgroundColor = .gray.withAlphaComponent(0.5)
        descriptionContainerView.layer.masksToBounds = false
        

        
        city_name.font = .systemFont(ofSize: 20, weight: .bold)
        coord.font = .systemFont(ofSize: 12, weight: .light)
        time.font = .systemFont(ofSize: 12, weight: .light)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
