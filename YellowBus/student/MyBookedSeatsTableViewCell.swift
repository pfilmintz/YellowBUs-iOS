//
//  MyBookedSeatsTableViewCell.swift
//  YellowBus
//
//  Created by mac on 04/08/2021.
//

import UIKit

class MyBookedSeatsTableViewCell: UITableViewCell {
    
    var locateBusAction : (() -> ())?
    
    @IBOutlet weak var locateBusBtnView: UIButton!
    
    @IBOutlet weak var busStopImgView: UIImageView!
    @IBOutlet weak var dateImgView: UIImageView!
    
    @IBOutlet weak var ticketImgView: UIImageView!
    @IBOutlet weak var pickupTimeImgView: UIImageView!
    
    @IBOutlet weak var busImageView: UIImageView!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var pickupTimeLabel: UILabel!
   
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pickupLocationLabel: UILabel!
    
    @IBOutlet weak var leftTicketView: UIView!
    
    @IBOutlet weak var rightTicketView: UIView!
    
    @IBOutlet weak var ticketNoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    // light mode detected
                    
                    busStopImgView.setImageColor(color: UIColor.black)
                    busImageView.setImageColor(color: UIColor.black)
                    dateImgView.tintColor = UIColor.black
                    pickupTimeImgView.tintColor = UIColor.black
                    ticketImgView.setImageColor(color: UIColor.black)
                    
                    
                    
                    mainView.layer.cornerRadius = 8
                 //   mainView.layer.borderWidth = 1
                 //   mainView.layer.borderColor = UIColor.black.cgColor
                case .dark:
                    // dark mode detected
                    busImageView.setImageColor(color: UIColor.yellow)
                    
                    busStopImgView.setImageColor(color: UIColor.yellow)
                    busImageView.setImageColor(color: UIColor.yellow)
                    dateImgView.tintColor = UIColor.yellow
                    pickupTimeImgView.tintColor = UIColor.yellow
                    ticketImgView.setImageColor(color: UIColor.yellow)
                    
             /*
                    mainView.layer.borderWidth = 1
                    mainView.layer.borderColor = UIColor.gray.cgColor*/
                    mainView.layer.cornerRadius = 8
        @unknown default:
            print("")
        /*
            mainView.layer.borderWidth = 1
            mainView.layer.borderColor = UIColor.black.cgColor*/
            mainView.layer.cornerRadius = 8
        }
        
        
        
        locateBusBtnView.layer.cornerRadius = 8
        locateBusBtnView.layer.borderWidth = 1
        locateBusBtnView.layer.borderColor = UIColor.black.cgColor
        
        
        rightTicketView.layer.cornerRadius = rightTicketView.frame.size.width / 2
        leftTicketView.layer.cornerRadius = leftTicketView.frame.size.width / 2
        
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func locateBusAction(_ sender: UIButton) {
        
        locateBusAction?()
    }
    
}
