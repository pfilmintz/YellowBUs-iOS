//
//  AboutViewController.swift
//  YellowBus
//
//  Created by mac on 23/09/2021.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    @IBOutlet weak var logoIMageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ybbg2-1"))
        
        logoIMageView.layer.cornerRadius = logoIMageView.frame.size.width / 2
      

        // Do any additional setup after loading the view.
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
