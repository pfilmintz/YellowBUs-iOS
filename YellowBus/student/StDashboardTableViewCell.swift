//
//  StDashboardTableViewCell.swift
//  YellowBus
//
//  Created by mac on 31/07/2021.
//

import UIKit

class StDashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionImageBackgroundView: UIView!
    
    @IBOutlet weak var optionImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
