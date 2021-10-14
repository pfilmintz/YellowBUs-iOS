//
//  SelectRouteViewController.swift
//  YellowBus
//
//  Created by mac on 03/08/2021.
//

import UIKit

class SelectRouteViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var shuttleSegmentedControlView: UISegmentedControl!
    @IBOutlet weak var proceedBtnView: UIButton!
    
    @IBOutlet weak var selectRoute: UITextField!
    
    var shuttle = "Lecture Shuttle"
    var route = ""
    var route_date = ""
    var from = ""
    var to = ""
    let thePicker = UIPickerView()
    let routeData = [String](arrayLiteral: "Main Campus to City Campus","City Campus to Main Campus")
    var layer = CAShapeLayer()
    
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var logoImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 8
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.gray.cgColor
        
        logoImgView.layer.cornerRadius = logoImgView.frame.size.width / 2
        
        
        proceedBtnView.layer.borderWidth = 1
        proceedBtnView.layer.cornerRadius = 8
     //   proceedBtnView.layer.borderColor = UIColor.white.cgColor

        // Do any additional setup after loading the view.
        selectRoute.delegate = self
        
        selectRoute.inputView = thePicker
        thePicker.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    /*    let pi = CGFloat(Float.pi)
               let start:CGFloat = 0.0
               let end :CGFloat = pi
               
               // circlecurve
             let path: UIBezierPath = UIBezierPath();
               path.addArc(
                   withCenter: CGPoint(x:self.view.frame.width/4, y:0),
                   radius: 400,
                   startAngle: start,
                   endAngle: end,
                   clockwise: true
               )
        
       

    
        
                layer = CAShapeLayer()
               layer.fillColor = UIColor.yellow.cgColor
               layer.strokeColor = UIColor.yellow.cgColor
               layer.path = path.cgPath
               self.view.layer.addSublayer(layer)
        
        
         
        */
 
        self.view.bringSubviewToFront(mainView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
       /* for layer in self.view.layer.sublayers! {
           if layer.isKind(of: CAShapeLayer.self) {
              layer.removeFromSuperlayer()
           }
        }*/
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
      
            return false
      
    }
    
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        
            
            return routeData.count
        
        
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if(selectRoute.text == ""){
            selectRoute.text = routeData[row]
            route = routeData[row]
        }
        
        
      
            return routeData[row]
            
        
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //selectHall.resignFirstResponder()
        
       
        selectRoute.text = routeData[row]
        route = routeData[row]
            
        
        
    }
    
    @IBAction func proceedAction(_ sender: UIButton) {
        
        if(route != ""){
            
            if(route == "Main Campus to City Campus"){
                from = "Main Campus"
                to = "City Campus"
            }else{
                from = "City Campus"
                to = "Main Campus"
            }
        
        let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        guard let bookSeatViewController = mainstoryboard.instantiateViewController(withIdentifier: "BookSeatViewController") as?
                BookSeatViewController else{
                
                return
        }
        
            let currentDate = Date()
            bookSeatViewController.from = from
            bookSeatViewController.to = to
        bookSeatViewController.shuttle = shuttle
        bookSeatViewController.route = route
            bookSeatViewController.currentDate = currentDate
        self.navigationController?.pushViewController(bookSeatViewController, animated: true)
       
       
     //   bookSeatViewController.modalPresentationStyle = .fullScreen
    //   self.present(selectRouteViewController,animated: true,completion: nil)
            
        }else{
           
            
            
            let logoutAlertController = UIAlertController(title: "Check Route", message:
                "Please Select Route", preferredStyle: .alert)
            
            logoutAlertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            self.present(logoutAlertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func shuttleControlAction(_ sender: UISegmentedControl) {
        switch shuttleSegmentedControlView.selectedSegmentIndex
           {
           case 0:
               shuttle = "Lecture Shuttle"
           case 1:
            shuttle = "Exams Shuttle"
           default:
               break
           }
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
