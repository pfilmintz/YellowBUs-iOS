//
//  BookSeatViewController.swift
//  YellowBus
//
//  Created by mac on 31/07/2021.
//

import UIKit
import Firebase

struct ticketModel {
    var name = String()
    var date = String()
    var uid = String()
    var time = String()
    var pickup = String()
    var route = String()
    
    var numbr = String()
    var tkt = String()
    var key = String()
    var shttl = String()
    
}

// let newTicket : [String:Any] = ["name":userName ?? "","date":selectedDate,"time": pickup_time,"pickup":bus_stop,"uid":userID!,"route":route,"numbr":phoneNumber ?? "","tkt":ticketNo,"key":key!,"shttl": shuttle]

class BookSeatViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var pickupTimeImageView: UIImageView!
    @IBOutlet weak var routeLabel: UILabel!
    @IBOutlet weak var dateImageView: UIImageView!
    
    @IBOutlet weak var busStopImageView: UIImageView!
    
    @IBOutlet weak var selectPickupTime: UITextField!
    @IBOutlet weak var selectBusStop: UITextField!
    
    @IBOutlet weak var selectDate: UITextField!
    
    @IBOutlet weak var bookBtnView: UIButton!
    
    @IBOutlet weak var bookView: UIView!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var toLabel: UILabel!
    
    
    
    var todayDate = ""
    
    var selectedDate = ""
    var bus_stop = ""
    var pickup_time = ""
    var from = ""
    var to = ""
    
    let thePicker = UIPickerView()
    let datePickerView  : UIDatePicker = UIDatePicker()
    var id = ""
    var route = ""
    var shuttle = ""
    var layer = CAShapeLayer()
    
    var checkDate = Date()
    var currentDate = Date()
    
    let hallData = [String](arrayLiteral: "Mensah Sarbah Hall", "Legon Hall", "Akuafo Hall", "Volta Hall",
                            "Commonwealth Hall", "Jubilee Hall","Internationl Students Hostel",
                            "Dr Hilla Limann Hall","Alex Kwapong Hall","Elizabeth Sey Hall","Jean Nelson Hall","African Union Hall(Pent)",
                            "Evandy Hostel","JT Nelson Yankah Hall","Valco Trust Hostel","Korle Bu","Bani Hostel")
    
    
    let lecture_hall_pickup_time = [String](arrayLiteral: "5:30am to 6:30am",
                                            "8:00am to 9:00am"
                                       ,"10:50am to 11:20am",
                                       "1:00pm to 1:30pm",
                                       "3:00pm to 3:30pm",
                                       "5:00am to 5:40pm")
    
    let lecture_city_pickup_time =  [String](arrayLiteral:
                                    "10:00am",
                                    "12:00pm",
                                    "2:00pm to 2:30pm",
                                    "4:30pm",
                                    "8:00pm to 8:30pm")
    
    let exams_city_pickup_time =  [String](arrayLiteral:
                                            "9:30am",
                                "10:30am",
                                "1:30pm",
                                "2:30pm",
                                "5:30pm",
                                "6:50pm")
    
    let exams_hall_pickup_time =  [String](arrayLiteral:
                                            "4:00am",
                                                    "4:45am",
                                                    "5:30am",
                                                    "6:00am",
                                                    "7:00am",
                                                    "8:50am",
                                                    "10:00am",
                                                    "11:30am",
                                                    "1:00pm")
    
    
    
    @objc func TextBoxOn(_ textField: UITextField) {
   // code
         id = "hall"
        thePicker.reloadAllComponents()
        
}
    
    @objc func TextBoxOff(_ textField: UITextField) {
       // thePicker.reloadAllComponents()
       
}
    
    @objc func PickupTextBoxOn(_ textField: UITextField) {
   // code
        id = "pickup"
       thePicker.reloadAllComponents()
        
}
    
    @objc func PickupTextBoxOff(_ textField: UITextField) {
        
       // thePicker.reloadAllComponents()
       
}
    
    @objc func DateTextBoxOn(_ textField: UITextField) {
   // code
        
        if(selectDate.text! == ""){
        selectDate.text = todayDate
            selectedDate = todayDate
        }
        
}
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        /*
        for layer in self.view.layer.sublayers! {
           if layer.isKind(of: CAShapeLayer.self) {
              layer.removeFromSuperlayer()
           }
        }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
      /*  let pi = CGFloat(Float.pi)
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
               self.view.layer.addSublayer(layer)*/
        
       
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    // light mode detected
                    
                    busStopImageView.setImageColor(color: UIColor.black)
                    dateImageView.tintColor = UIColor.black
                    pickupTimeImageView.tintColor = UIColor.black
                case .dark:
                    // dark mode detected
                    busStopImageView.tintColor = UIColor.yellow
                    busStopImageView.setImageColor(color: UIColor.yellow)
        @unknown default:
            print("")
            busStopImageView.setImageColor(color: UIColor.black)
            dateImageView.tintColor = UIColor.black
            pickupTimeImageView.tintColor = UIColor.black
        }
        
        
        
        bookView.layer.cornerRadius = 8
        bookView.layer.borderWidth = 0.5
        bookView.layer.borderColor = UIColor.gray.cgColor
        
        bookBtnView.layer.borderWidth = 1
        bookBtnView.layer.cornerRadius = 8
     //   bookBtnView.layer.borderColor = UIColor.black.cgColor
        
      /*  backView.layer.cornerRadius = 32
        backView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
 */
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "E, d MMM yyyy"
        
        // Apply date format
        todayDate = dateFormatter.string(from: currentDate)
        
        
        
      //  routeLabel.text = " \(route) \n" + "\(shuttle)"
        
        routeLabel.text = shuttle
        
        fromLabel.text = from
        toLabel.text = to
        
         
        
        if(shuttle == "Lecture Shuttle"){
            shuttle = "lecture"
        }
        
        if(shuttle == "Exams Shuttle"){
            shuttle = "exams"
        }
        
        
        if(route == "Main Campus to City Campus"){
            route = "m2c"
        }
        
        if(route == "City Campus to Main Campus"){
            route = "c2m"
        }
       
        
    //    routeLabel.text = "\(shuttle)"
        
     
        
        thePicker.delegate = self
        selectDate.delegate = self
        selectBusStop.delegate = self
        
        selectBusStop.addTarget(self, action: #selector(TextBoxOn(_:)),for: .editingDidBegin)
        selectBusStop.addTarget(self, action: #selector(TextBoxOff(_:)),for: .editingDidEnd)
        
        
        
        selectPickupTime.delegate = self
        selectPickupTime.addTarget(self, action: #selector(PickupTextBoxOn(_:)),for: .editingDidBegin)
        selectPickupTime.addTarget(self, action: #selector(PickupTextBoxOff(_:)),for: .editingDidEnd)
        selectPickupTime.inputView = thePicker
        
        
        selectBusStop.inputView = thePicker
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.date = Date()
      //  datePickerView.locale = .current
        
       
       
        
        selectDate.inputView = datePickerView
        selectDate.addTarget(self, action: #selector(DateTextBoxOn(_:)),for: .editingDidBegin)
        datePickerView.addTarget(self, action: #selector(BookSeatViewController.datePickerValueChanged(_:)), for: .valueChanged)
       
        
      //  addNavigationBar()
        
        
        /*      let pi = CGFloat(Float.pi)
            //   let start:CGFloat = 0.0
            //   let end :CGFloat = pi
               
               // circlecurve
             let path: UIBezierPath = UIBezierPath();
               path.addArc(
                   withCenter: CGPoint(x:self.view.frame.width/4, y:0),
                   radius: 400,
                   startAngle: start,
                   endAngle: end,
                   clockwise: true
               )
        
       

        
        
        let path = UIBezierPath()
            path.move(to: start)
            path.addLine(to: end)
        
      
        
               let layer = CAShapeLayer()
               layer.fillColor = UIColor.yellow.cgColor
               layer.strokeColor = UIColor.yellow.cgColor
               layer.path = path.cgPath
               self.view.layer.addSublayer(layer)
 
         */
        
        
        
       // self.view.bringSubviewToFront(bookView)
        
        
        self.view.bringSubviewToFront(bookView)

        // Do any additional setup after loading the view.
    }
    
  
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        
        checkDate = sender.date
           
           // Create date formatter
           let dateFormatter: DateFormatter = DateFormatter()
           
           // Set date format
           dateFormatter.dateFormat = "E, d MMM yyyy"
           
           // Apply date format
        selectedDate = dateFormatter.string(from: sender.date)
           
           print("Selected value \(selectedDate)")
        
        selectDate.text =  selectedDate
            
        
        
       }
       
    
    
   
    
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if (id == "hall") {
            
           return hallData.count
        }else{
            
            if(shuttle == "lecture"){
            if(route == "m2c"){
            
            return lecture_hall_pickup_time.count
                
            }else{
                return lecture_city_pickup_time.count
            }
            
            }else{
                if(route == "m2c"){
                
                return exams_hall_pickup_time.count
                    
                }else{
                    return exams_city_pickup_time.count
                }
            }
        }
        
        
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (id == "hall") {
            if(selectBusStop.text == ""){
                selectBusStop.text = hallData[row]
                bus_stop = hallData[row]
            }
            
            
            
           return hallData[row]
        }else{
            if(shuttle == "lecture"){
            if(route == "m2c"){
                
                if(selectPickupTime.text == ""){
                    selectPickupTime.text = lecture_hall_pickup_time[row]
                    pickup_time = lecture_hall_pickup_time[row]
                }
            
            return lecture_hall_pickup_time[row]
                
            }else{
                
                if(selectPickupTime.text == ""){
                    selectPickupTime.text = lecture_city_pickup_time[row]
                    pickup_time = lecture_city_pickup_time[row]
                }
                
                return lecture_city_pickup_time[row]
            }
            
            }else{
                if(route == "m2c"){
                    
                    if(selectPickupTime.text == ""){
                        selectPickupTime.text = exams_hall_pickup_time[row]
                        pickup_time = exams_hall_pickup_time[row]
                    }
                
                return exams_hall_pickup_time[row]
                    
                }else{
                    if(selectPickupTime.text == ""){
                        selectPickupTime.text = exams_city_pickup_time[row]
                        pickup_time = exams_city_pickup_time[row]
                    }
                    return exams_city_pickup_time[row]
                }
            }
            
        }
            
        
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //selectHall.resignFirstResponder()
        
        
        if (id == "hall") {
            
        selectBusStop.text = hallData[row]
            bus_stop = hallData[row]
            
        }else{
            
            if(shuttle == "lecture"){
            if(route == "m2c"){
            
                selectPickupTime.text = lecture_hall_pickup_time[row]
                pickup_time = lecture_hall_pickup_time[row]
                
            }else{
                selectPickupTime.text = lecture_city_pickup_time[row]
                pickup_time = lecture_city_pickup_time[row]
            }
            
            }else{
                if(route == "m2c"){
                
                    selectPickupTime.text = exams_hall_pickup_time[row]
                    pickup_time = exams_hall_pickup_time[row]
                    //
                    
                }else{
                    selectPickupTime.text = exams_city_pickup_time[row]
                    pickup_time = exams_city_pickup_time[row]
                }
            }
            
        }
            
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
      
            return false
      
    }
    
  
    
    
   
    
  
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    func errorAlert(title: String, message: String){
        
        
      /*  func confirmUnfollow(_ action: UIAlertAction) {
            if action.title! == "Proceed"{
                
                checkBalance()
            }
            
        }*/
        
        let logoutAlertController = UIAlertController(title: title, message:
                                                        message, preferredStyle: .alert)
       // logoutAlertController.addAction(UIAlertAction(title: "", style: .default, handler: confirmUnfollow))
        logoutAlertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        self.present(logoutAlertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func bookBtnAction(_ sender: UIButton) {
        
       
        if(bus_stop == ""){
            
            errorAlert(title: "Check Pickup Location", message: "Please Select Pickup Location")
            return
            
        }
        
         if(pickup_time == ""){
            errorAlert(title: "Check Pickup Time", message: "Please Select Pickup Time")
            return
        }
        
         if(selectedDate == ""){
            errorAlert(title: "Check Date", message: "Please Select Date")
            return
        }
        
        let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        guard let confirmBookingViewController = mainstoryboard.instantiateViewController(withIdentifier: "ConfirmBookingViewController") as?
                ConfirmBookingViewController else{
                
                return
        }
        
           
        confirmBookingViewController.from = from
        confirmBookingViewController.to = to
        confirmBookingViewController.mShuttle = shuttle
        confirmBookingViewController.mRoute = route
        confirmBookingViewController.mDate = selectedDate
        confirmBookingViewController.mPickupTime = pickup_time
        confirmBookingViewController.mBusStop = bus_stop
        self.navigationController?.pushViewController(confirmBookingViewController, animated: true)
        
        
        
        /*        if (checkDate.timeIntervalSinceNow.sign == .minus) {
            // date is in past
            errorAlert(title: "Check Date", message: "You cannot select a past date!")
            return
        }
 
      
        
       if(checkDate < currentDate){
            errorAlert(title: "Check Date", message: "You cannot select a past date!")
            return
        }
         */
        
       
        
        
        
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
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
