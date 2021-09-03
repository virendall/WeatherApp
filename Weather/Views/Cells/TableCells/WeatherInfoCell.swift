//
//  WeatherInfoCell.swift
//  Weather
//
//  Created by Virender Dall on 31/08/21.
//

import UIKit

class WeatherInfoCell: UITableViewCell {

    @IBOutlet var weatherView: WeatherInfoView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
