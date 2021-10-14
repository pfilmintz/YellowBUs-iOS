//
//  SeatBookedAlertViewController.swift
//  YellowBus
//
//  Created by mac on 04/08/2021.
//

import UIKit

class SeatBookedAlertViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var doneBtnView: UIButton!
    @IBOutlet weak var doneImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var routeLabel: UILabel!
    
    @IBOutlet weak var pickupTimeLabel: UILabel!
    
    @IBOutlet weak var ticketNoLabel: UILabel!
    
    @IBOutlet weak var busStopLabel: UILabel!
    
    var date = ""
    var route = ""
    var pickuptime = ""
    var ticketNo = ""
    var busstop = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 8
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.gray.cgColor
        
        doneImageView.layer.cornerRadius = doneImageView.frame.size.width / 2
        
        doneBtnView.layer.cornerRadius = 8
        doneBtnView.layer.borderWidth = 1
        doneBtnView.layer.borderColor = UIColor.black.cgColor
        
        dateLabel.text = date
        pickupTimeLabel.text = pickuptime
        busStopLabel.text = busstop
        ticketNoLabel.text = ticketNo
        
       
        
        if(route == "m2c"){
            routeLabel.text = "Main Campus to City Campus"
        }else{
            routeLabel.text = "City Campus to Main Campus"
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
