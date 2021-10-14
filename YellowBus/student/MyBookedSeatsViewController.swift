//
//  MyBookedSeatsViewController.swift
//  YellowBus
//
//  Created by mac on 31/07/2021.
//

import UIKit
import Firebase

class MyBookedSeatsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tickets = [ticketModel]()
    var date = ""
    var todayDate = ""
    let currentDate = Date()
    var loadalertController = UIAlertController()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadalertController = UIAlertController(title: nil, message:
            "Loading Please Wait\n\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(style: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        self.loadalertController.view.addSubview(spinnerIndicator)
        
          DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
            DispatchQueue.main.async {
               self.present(self.loadalertController, animated: true, completion : {
               self.loadalertController.view.superview?.isUserInteractionEnabled = true
               self.loadalertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
                    })
            }
               })
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "E, d MMM yyyy"
        
        // Apply date format
        todayDate = dateFormatter.string(from: currentDate)
        
        
        
    
        
        loadTickets()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func loadTickets(){
        let userID  = Auth.auth().currentUser?.uid
        
        let myBookedSeatsDb = Database.database().reference().child("myBookedSeats")
        
       
        
        
        
        myBookedSeatsDb.child(userID!).child(date).observeSingleEvent(of: .value, with: { snapshot in
            if(snapshot.hasChildren()){
                DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                  DispatchQueue.main.async {
                self.loadalertController.dismiss(animated: true, completion: nil);
                    
                  }})
          for child in snapshot.children.allObjects as! [DataSnapshot]  {
                       
                       
                       let dict = child.value as? [String: AnyObject]
                       let name = dict?["name"] as? String
                        let date = dict?["date"] as? String
            let time = dict?["time"] as? String
             let pickup = dict?["pickup"] as? String
            let uid = dict?["uid"] as? String
             let route = dict?["route"] as? String
            let numbr = dict?["numbr"] as? String
             let tkt = dict?["tkt"] as? String
            let shttl = dict?["shttl"] as? String
             let key = dict?["key"] as? String
            
            if(key != nil){
            
                let newPost = ticketModel(name: name ?? "",date: date!, uid: uid!,time: time!,pickup: pickup!,route: route!, numbr: numbr ?? "",tkt: tkt!,key:key!,shttl: shttl!)
            
                        self.tickets.insert(newPost,at:0)
                              
                              let indexPath = IndexPath(row:0,section:0)
                              self.tableView.insertRows(at: [indexPath], with: .top)
            }
                    
            }
            }else{
                DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                       DispatchQueue.main.async {
                        self.loadalertController.dismiss(animated: true, completion: {
                let alertController = UIAlertController(title: "Done Loading", message:
                    "No Tickets Booked On This Day", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                
                    self.present(alertController, animated: true, completion: nil)})
                        
                       }})
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tickets.count
       }
    
    
    
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Configure the cell...
           
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBookedSeatsTableViewCell", for: indexPath)
        as! MyBookedSeatsTableViewCell
        
        // Configure the cell...
        let ticketsList: ticketModel?
        ticketsList = tickets[indexPath.row]
        
        cell.dateLabel.text = ticketsList?.date
        
        
        if(ticketsList?.route == "m2c"){
            cell.toLabel.text = "Main Campus"
            cell.fromLabel.text = "City Campus"
            
        }else{
            cell.toLabel.text = "City Campus"
            cell.fromLabel.text = "Main Campus"
        }
      //  cell.routeLabel.text = ticketsList?.route
        
        cell.pickupTimeLabel.text = ticketsList?.time
        cell.pickupLocationLabel.text = ticketsList?.pickup
        cell.ticketNoLabel.text = ticketsList?.tkt
        
        
        
        
        
        if(date == todayDate ){
            cell.locateBusBtnView.isHidden = false
        }
        
        if(date != todayDate ){
            cell.locateBusBtnView.isHidden = true
        }
        
        cell.selectionStyle = .none
        
        cell.locateBusAction = { [weak self] in
            
            
            
            if let strongSelf = self {
                
                //locatebus
                let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                guard let LocationViewController = mainstoryboard.instantiateViewController(withIdentifier: "LocationViewController") as?
                        LocationViewController else{
                        
                        return
                }
              //  let bus = ticketsList?.tkt
             //   LocationViewController.bus = bus
            
                
                strongSelf.navigationController?.pushViewController(LocationViewController, animated: true)
                
            }
        }
        
       
        
        
        return cell
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
