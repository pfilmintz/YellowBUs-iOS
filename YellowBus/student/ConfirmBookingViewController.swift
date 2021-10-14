//
//  ConfirmBookingViewController.swift
//  YellowBus
//
//  Created by mac on 08/09/2021.
//

import UIKit
import Alamofire
import Firebase

//encoding => model to json
//decoding => json to model

struct PaymentRequestResponse: Codable {
    
    let responseCode: String
    let status: String
    let data: PaymentRequestResponseData
    
}



struct PaymentRequestResponseData: Codable  {
    let checkoutUrl: String
    let checkoutId: String
    let clientReference: String
    let message: String
    let checkoutDirectUrl: String
}

class ConfirmBookingViewController: UIViewController {
    
    
    @IBOutlet weak var busStopImg: UIImageView!
   
    @IBOutlet weak var busImg: UIImageView!
   
    @IBOutlet weak var timeImg: UIImageView!
    
    
    @IBOutlet weak var dateImg: UIImageView!
    
    @IBOutlet weak var paymentBtnView: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var bookBtnView: UIButton!
    
    
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var busStopLabel: UILabel!
    
    @IBOutlet weak var leftTicketView: UIView!
    
    @IBOutlet weak var rightTicketView: UIView!
    @IBOutlet weak var shuttleLabel: UILabel!
    
    @IBOutlet weak var pickupTimeLabel: UILabel!
    
    
    var number = 0
    var busCount = 0
    var bus = ""
    var ticketNo = ""
    var mTime = ""
    var mDate = ""
    var mRoute = ""
    var mPickupTime = ""
    var mBusStop = ""
    var mShuttle = ""
    var from = ""
    var to = ""
    var phoneNumber:String?
    var userName:String?
    var clientReference: String?
    var date_time = ""
    
    var loadalertController = UIAlertController()
    var userID: String?
    var myAccountBalance: DatabaseReference!
    var balance = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadalertController = UIAlertController(title: nil, message:
            "Loading Please Wait\n\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(style: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        loadalertController.view.addSubview(spinnerIndicator)
        
        
             self.present(self.loadalertController, animated: true, completion : {
             self.loadalertController.view.superview?.isUserInteractionEnabled = true
             self.loadalertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
                  })
        
        
        
         phoneNumber  = UserDefaults.standard.object(forKey: "phoneNumber") as? String
        
         userName = UserDefaults.standard.object(forKey: "name") as? String
        
        
        toLabel.text = to
        fromLabel.text = from
        if("lecture" == mShuttle){
            shuttleLabel.text = "Lecture Shuttle"
        }else{
            shuttleLabel.text = "Exams Shuttle"
        }
        
        dateLabel.text = mDate
        busStopLabel.text = mBusStop
  //      phoneNumberLabel.text = phoneNumber ?? ""
        pickupTimeLabel.text = mPickupTime
     //   userNameLabel.text = userName ?? ""

        
        userID  = Auth.auth().currentUser?.uid
        
        
        myAccountBalance = Database.database().reference().child("account_balance")
        
        // Do any additional setup after loading the view.'
        
        switch traitCollection.userInterfaceStyle {
                case .light, .unspecified:
                    // light mode detected
                    
                    busStopImg.setImageColor(color: UIColor.black)
                    busImg.setImageColor(color: UIColor.black)
                    dateImg.tintColor = UIColor.black
                    timeImg.tintColor = UIColor.black
                    
                case .dark:
                    // dark mode detected
                    busStopImg.tintColor = UIColor.yellow
                    busStopImg.setImageColor(color: UIColor.yellow)
                    busImg.tintColor = UIColor.yellow
                    busImg.setImageColor(color: UIColor.yellow)
                    dateImg.tintColor = UIColor.yellow
                    timeImg.tintColor = UIColor.yellow
        @unknown default:
            print("")
            busStopImg.tintColor = UIColor.black
            busStopImg.setImageColor(color: UIColor.black)
            busImg.setImageColor(color: UIColor.yellow)
            dateImg.tintColor = UIColor.black
            timeImg.tintColor = UIColor.black
            
        }
        
        mainView.layer.cornerRadius = 8
    //    mainView.layer.borderWidth = 0.5
      //  mainView.layer.borderColor = UIColor.gray.cgColor
        
        bookBtnView.layer.cornerRadius = 8
        bookBtnView.layer.borderWidth = 0.5
        bookBtnView.layer.borderColor = UIColor.gray.cgColor
        
        paymentBtnView.layer.cornerRadius = 8
        paymentBtnView.layer.borderWidth = 0.5
        paymentBtnView.layer.borderColor = UIColor.gray.cgColor
        
        rightTicketView.layer.cornerRadius = rightTicketView.frame.size.width / 2
        leftTicketView.layer.cornerRadius = leftTicketView.frame.size.width / 2
        
        
        bookBtnView.isHidden = true
        paymentBtnView.isHidden = true
        
        
        
        
        
        checkBalance()
        
        
        let currentDate = Date()
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        
        // Apply date format
         date_time = dateFormatter.string(from: currentDate)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(clientReference != nil){
            
            
            let paymentsDb = Database.database().reference().child("payments")
            
            paymentsDb.child(userID!).child(clientReference!).observeSingleEvent(of: .value, with: { [self] ( snapshot) in
                if(snapshot.exists()){
                    
                    confirmAlert(amount: 4)
                    
                }
                self.checkBalance()
            })
            
        }
    }
    
    func checkBalance(){
        
        
        
        
         
         myAccountBalance.child(userID!).child("balance").observeSingleEvent(of: .value, with: { [self] ( snapshot) in
         if(snapshot.exists()){
             
            balance = snapshot.value as! Int
            
         }
           
                 
                if(balance >= 4){
                    
                    bookBtnView.isHidden = false
                    paymentBtnView.isHidden = true
                    
                    
                }else{
                    
                    paymentBtnView.isHidden = false
                    bookBtnView.isHidden = true
                    
                   
                    
                    
                }
            
         
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
              DispatchQueue.main.async {
            self.loadalertController.dismiss(animated: true, completion: nil);
                
              }})
              
            
             
         
     })
        
    
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
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    
    func confirmAlert(amount: Int){
        
        func confirmUnfollow(_ action: UIAlertAction) {
            if action.title! == "Proceed"{
                
                loadalertController = UIAlertController(title: nil, message:
                    "Loading Please Wait\n\n\n", preferredStyle: .alert)
                
                let spinnerIndicator = UIActivityIndicatorView(style: .whiteLarge)
                
                spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
                spinnerIndicator.color = UIColor.black
                spinnerIndicator.startAnimating()
                
                loadalertController.view.addSubview(spinnerIndicator)
                
                
                     self.present(self.loadalertController, animated: true, completion : {
                     self.loadalertController.view.superview?.isUserInteractionEnabled = true
                     self.loadalertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
                          })
                
                let DBavailableBuses = Database.database().reference().child("available_buses")
                let DBbookedBuses = Database.database().reference().child("booked_buses")
                
               DBavailableBuses.child(mDate).observeSingleEvent(of: .value, with: { [self] ( snapshot) in
                if(snapshot.exists()){
                    
                    busCount = snapshot.value as? Int ?? 7
                   
                   
                   
                }else{
                  
                   busCount = 7
                }
                   
                   DBbookedBuses.child(mDate).child(mRoute).child(mPickupTime).observeSingleEvent(of: .value, with: { [self] ( snapshot) in
                    
                       let bus_available = snapshot.childrenCount
                       
                       let count = Int(bus_available)
                    
                    if(count <= busCount * 29 ){
                        
                        bookSeat(myamount: amount)
                        
                    }else{
                        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                               DispatchQueue.main.async {
                                self.loadalertController.dismiss(animated: true, completion: {
                        let alertController = UIAlertController(title: "Sorry", message:
                            "All Buses Booked At This Time", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default))
                        
                            self.present(alertController, animated: true, completion: nil)})
                                
                               }})
                    }
                    

                    
                   })
                
               })
                
                 
                
                
            }
            
        }
        
        let logoutAlertController = UIAlertController(title: "Confirm Book Seat", message:
            "Proceed to Book a Seat for GH¢4", preferredStyle: .alert)
        logoutAlertController.addAction(UIAlertAction(title: "Proceed", style: .default, handler: confirmUnfollow))
        logoutAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlertController, animated: true, completion: nil)
        
    }
    
    func bookSeat(myamount: Int){
        
        
        
        let DBavailableBuses = Database.database().reference().child("available_buses")
        let DBbookedBuses = Database.database().reference().child("booked_buses")
        let DBbookedSeats = Database.database().reference().child("booked_seats");
        let DBTotalbookedSeatsCount = Database.database().reference().child("total_booked_seats_count")
        let DBTotalbookedSeats = Database.database().reference().child("total_booked_seats")
        let DBbookedBus = Database.database().reference().child("booked_bus");
        
        let myBookedSeatsCountDb = Database.database().reference().child("myBookedSeatsCount")
        let user_bookingsDB = Database.database().reference().child("user_bookings")
     
        
       
        let myBookedSeatsDb = Database.database().reference().child("myBookedSeats")
        
        
       
        
         
        DBavailableBuses.child(mDate).observeSingleEvent(of: .value, with: { [self] ( snapshot) in
         if(snapshot.exists()){
             
             busCount = snapshot.value as? Int ?? 7
            
            
            
         }else{
           
            busCount = 7
         }
            
            DBbookedBuses.child(mDate).child(mRoute).child(mPickupTime).observeSingleEvent(of: .value, with: { [self] ( snapshot) in
             
                let bus_available = snapshot.childrenCount
                
                let count = Int(bus_available)
                
                if(count >= 0 && count < 29 && busCount >= 1 ){
                    
              
                    ticketNo = "A\(count + 1)"
                    bus = "A";

                }
                else if(count >= 29 && count < 58 && busCount >= 2 ){
                    
                    number = count - 29;
                    ticketNo = "B\(count + 1)"
                    bus = "B";

                }
                else if(count >= 58 && count < 87 && busCount >= 3 ){
                    
                    number = count - 58;
                    ticketNo = "C\(count + 1)"
                    bus = "C";

                }
                else if(count >= 87 && count < 116 && busCount >= 4 ){
                    
                    number = count - 87;
                    ticketNo = "D\(count + 1)"
                    bus = "D";

                }
                else if(count >= 116 && count < 145 && busCount >= 5 ){
                    
                    number = count - 116;
                    ticketNo = "E\(count + 1)"
                    bus = "E";

                }
                else if(count >= 145 && count < 174 && busCount >= 6 ){
                    
                    number = count - 145;
                    ticketNo = "F\(count + 1)"
                    bus = "F";

                }
                else if(count >= 174 && count < 203 && busCount == 7 ){
                    
                    number = count - 174;
                    ticketNo = "G\(count + 1)"
                    bus = "G";

                }else{
                    DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                           DispatchQueue.main.async {
                            self.loadalertController.dismiss(animated: true, completion: {
                    let alertController = UIAlertController(title: "Sorry", message:
                        "All Buses Booked At This Time", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    
                        self.present(alertController, animated: true, completion: nil)
                                
                            })
                            
                           }})
                    return
                }
                
                let key = DBTotalbookedSeats.childByAutoId().key

                
                
                
                 
                let newTicket : [String:Any] = ["name":userName ?? "","date":mDate,"time": mPickupTime,"pickup":mBusStop,"uid":userID!,"route":mRoute,"numbr":phoneNumber ?? "","tkt":ticketNo,"key":key!,"shttl": mShuttle]

                
                let newBalance = myamount - 4;

                myAccountBalance.child(userID!).child("balance").setValue(newBalance){
                    (error: Error?, ref: DatabaseReference) in
                    if let error = error{
                        print("Data could not be saved: \(error).")
                        
                        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                               DispatchQueue.main.async {
                                self.loadalertController.dismiss(animated: true, completion: {
                                    errorAlert(title: "Booking Failed!", message: "Please Try Again!!")
                                    
                                })
                                
                               }})
                        
                        
                        
                    }else{
                        
                        print("success")
                        
                        bookBtnView.isHidden = true
                        paymentBtnView.isHidden = true
                        
                        
                        
                        //admin
                        DBTotalbookedSeats.child(key!).setValue(newTicket)
                        DBTotalbookedSeatsCount.child(key!).setValue(true)


                        DBbookedBuses.child(mDate).child(mRoute).child(mPickupTime).child(userID!).setValue(true)

                        //admin check
                        DBbookedSeats.child(mDate).child(mRoute).child(mPickupTime).child(userID!).setValue(newTicket)


                        //driver
                        DBbookedBus.child(mDate).child(mRoute).child(mPickupTime).child(bus).child(userID!).setValue(newTicket)

                        //student
                        myBookedSeatsDb.child(userID!).child(mDate).child(key!).setValue(newTicket)
                        
                        //student
                        myBookedSeatsCountDb.child(userID!).child(key!).setValue(true);

                        //String route,String date,String time,String key) {

                        let user_booking : [String:Any] = ["route":mRoute,"date_time":date_time,"key":key!]

                       
                        //bookingsDb
                        user_bookingsDB.child(userID!).child(key!).setValue(user_booking);
                        
                        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                          DispatchQueue.main.async {
                            self.loadalertController.dismiss(animated: true, completion :{
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                guard let myAlert = storyboard.instantiateViewController(withIdentifier: "SeatBookedAlertViewController") as?
                                        SeatBookedAlertViewController else{
                                        
                                        return
                                }
                                
                                myAlert.date = mDate
                                
                                
                                myAlert.route = mRoute
                                myAlert.pickuptime = mPickupTime
                                myAlert.ticketNo = ticketNo
                                myAlert.busstop = mBusStop
                                
                                        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                                        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                        self.present(myAlert, animated: true, completion: nil)
                                
                                
                                })
                           
                            
                          }})

                        
                    
                   
                    
                    
                        
                    }
                    }
                


                
                
                
         })
            
            
     })
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func payBtnAction(_ sender: Any) {
        initPayment()
        
        
    }
    
    @IBAction func bookSeatAction(_ sender: UIButton) {
        if(balance >= 4) {
            confirmAlert(amount: balance)
                        }
    }
    
    func initPayment(){
        
        loadalertController = UIAlertController(title: nil, message:
            "Loading Please Wait\n\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(style: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        loadalertController.view.addSubview(spinnerIndicator)
        
        
             self.present(self.loadalertController, animated: true, completion : {
             self.loadalertController.view.superview?.isUserInteractionEnabled = true
             self.loadalertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
                  })
       
        
        
        struct PaymentData: Codable {
            let totalAmount: Int
            let description: String
            let callbackUrl: String
            let returnUrl: String
            let merchantAccountNumber: String
            let cancellationUrl: String
            let clientReference: String
            
        }
        
         let callbackUrl = "https://us-central1-yellowbus-832f4.cloudfunctions.net/recordPayment"
        
        let returnUrl = "https://webhook.site/7723aa5b-2c5e-4948-a4e0-2050956db5f4";
        
        let cancellationUrl = "https://webhook.site/7723aa5b-2c5e-4948-a4e0-2050956db5f4";

     //   let callbackUrl = "http://localhost:5001/yellowbus-832f4/us-central1/recordPayment"
        
        let clientReferenceDB = Database.database().reference().child("HubtelClientReference")
        
        clientReference = clientReferenceDB.childByAutoId().key
        
        let data = PaymentData(totalAmount: 1, description: "Payment for seat",callbackUrl: callbackUrl, returnUrl: returnUrl,merchantAccountNumber: "1392210", cancellationUrl: cancellationUrl, clientReference: clientReference!)
        
        
    
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic OGdMakRMOjQxMGVmMjc0NTc1MjRiODFiMjYzOTJkZTkwYTIyZjc5",
            "Content-Type" :"application/json"
        ]

        AF.request("https://payproxyapi.hubtel.com/items/initiate", method: .post, parameters: data, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { [self] response in
            debugPrint(response)
                switch response.result {
                    case .success:
                        print("succes!")
                        
                       
                        
                        
                        
                        guard let data = response.data else { return }
                        
                        let decoder = JSONDecoder()
                        
                        do {
                                let payment = try decoder.decode(PaymentRequestResponse.self, from: data)
                          
                            
                            let checkoutUrl = payment.data.checkoutUrl
                            
                            
                            
                            let clientData : [String:Any] = ["uid":userID!,"date_time":date_time]
                            
                            
                            clientReferenceDB.child(clientReference!).setValue(clientData){
                                (error: Error?, ref: DatabaseReference) in
                                if let error = error{
                                    print("Data could not be saved: \(error).")
                                    
                                    
                                    DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                                      DispatchQueue.main.async {
                                        self.loadalertController.dismiss(animated: true, completion :{
                                            self.errorAlert(title: "Payment Failed!", message: "Please Try Again!!")
                                            
                                            })
                                        
                                   
                                        
                                      }})
                                    
                                    
                                }else{
                                    print("success")
                                    
                                    DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                                      DispatchQueue.main.async {
                                    self.loadalertController.dismiss(animated: true, completion: {
                                        
                                        let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                                        guard let hubtelPaymentViewController = mainstoryboard.instantiateViewController(withIdentifier: "HubtelPaymentViewController") as?
                                                HubtelPaymentViewController else{
                                                
                                                return
                                        }
                                        hubtelPaymentViewController.url = checkoutUrl
                                        self.navigationController?.pushViewController(hubtelPaymentViewController, animated: true)
                                        
                                      })
                                        
                                        
                                      }})
                                    
                                    
                                }
                            }
                            
                            
                            } catch {
                                print(error.localizedDescription)
                                DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                                  DispatchQueue.main.async {
                                    self.loadalertController.dismiss(animated: true, completion :{
                                        self.errorAlert(title: "Payment Failed!", message: "Please Try Again!!")
                                        
                                        })
                                    
                               
                                    
                                  }})
                                
                            }
                        
                      
                        
                        
                        
                        
                    case .failure(let error):
                        print(error)
                        print(response.response?.statusCode)
                        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                          DispatchQueue.main.async {
                            self.loadalertController.dismiss(animated: true, completion :{
                                self.errorAlert(title: "Payment Failed!", message: "Please Try Again!!")
                                
                                })
                            
                       
                            
                          }})
                        
                        
                    }
        }
        
    }
    
  

}
