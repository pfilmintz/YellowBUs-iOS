//
//  StudentDashboardViewController.swift
//  YellowBus
//
//  Created by mac on 31/07/2021.
//

import UIKit
import Firebase




class StudentDashboardViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var bookBusView: UIView!
    @IBOutlet weak var bookBusImageView: UIView!
    
    @IBOutlet weak var myTicketsView: UIView!
    @IBOutlet weak var ticketView: UIView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var aboutView: UIView!
    
    @IBOutlet weak var ybView: UIView!
    
    @IBOutlet weak var invitesView: UIView!
    
    @IBOutlet weak var imgInviteView: UIView!
    
    @IBOutlet weak var supportView: UIView!
    
    @IBOutlet weak var supportMainView: UIView!
    
    @IBOutlet weak var socialMainView: UIView!
    
    @IBOutlet weak var socialView: UIView!
    
    var frame = CGRect.zero
    
    var pagerImages = [UIImage]()
    
    var userID: String?
    var selectedDate = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        aboutView.layer.cornerRadius = 8
        ybView.layer.cornerRadius = 8
        ybView.layer.borderWidth = 0.5
        ybView.layer.borderColor = UIColor.gray.cgColor
        
        let viewAbout = UITapGestureRecognizer(target: self, action: #selector(StudentDashboardViewController.aboutFunction))
        aboutView.isUserInteractionEnabled = true
        aboutView.addGestureRecognizer(viewAbout)
        
        invitesView.layer.cornerRadius = 8
        imgInviteView.layer.cornerRadius = 8
        imgInviteView.layer.borderWidth = 0.5
        imgInviteView.layer.borderColor = UIColor.gray.cgColor
        
        let openInvites = UITapGestureRecognizer(target: self, action: #selector(StudentDashboardViewController.invitesFunction))
        invitesView.isUserInteractionEnabled = true
        invitesView.addGestureRecognizer(openInvites)
        
        
        bookBusView.layer.cornerRadius = 8
        
        bookBusImageView.layer.cornerRadius = 8
        bookBusImageView.layer.borderWidth = 0.5
        bookBusImageView.layer.borderColor = UIColor.gray.cgColor
        
        let openbookbus = UITapGestureRecognizer(target: self, action: #selector(StudentDashboardViewController.bookbusFunction))
        bookBusView.isUserInteractionEnabled = true
        bookBusView.addGestureRecognizer(openbookbus)
        
        ticketView.layer.cornerRadius = 8
        
        myTicketsView.layer.cornerRadius = 8
        
        ticketView.layer.borderWidth = 0.5
        ticketView.layer.borderColor = UIColor.gray.cgColor
        
        let openMytickets = UITapGestureRecognizer(target: self, action: #selector(StudentDashboardViewController.myticketsFunction))
        myTicketsView.isUserInteractionEnabled = true
        myTicketsView.addGestureRecognizer(openMytickets)
        
        
        
        
        supportView.layer.cornerRadius = 8
        supportView.layer.borderWidth = 0.5
        supportView.layer.borderColor = UIColor.gray.cgColor
        
        supportMainView.layer.cornerRadius = 8
        
        
        let openSupport = UITapGestureRecognizer(target: self, action: #selector(StudentDashboardViewController.supportFunction))
        supportMainView.isUserInteractionEnabled = true
        supportMainView.addGestureRecognizer(openSupport)
        
        socialMainView.layer.cornerRadius = 8
        socialView.layer.cornerRadius = 8
        socialView.layer.borderWidth = 0.5
        socialView.layer.borderColor = UIColor.gray.cgColor
        
        let openSocial = UITapGestureRecognizer(target: self, action: #selector(StudentDashboardViewController.socialFunction))
        socialMainView.isUserInteractionEnabled = true
        socialMainView.addGestureRecognizer(openSocial)
        
        userID  = Auth.auth().currentUser?.uid
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "E, d MMM yyyy"
        
        // Apply date format
     selectedDate = dateFormatter.string(from: Date())
        
     /*
         //round bottom corners of view
         backView.layer.cornerRadius = 32
        backView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
 */
        
        
        
        pagerImages.append(UIImage(systemName: "heart.circle.fill" )!)
        pagerImages.append(UIImage(systemName: "person.crop.circle.fill")!)
        pagerImages.append(UIImage(systemName: "person.3.fill" )!)

            pageControl.numberOfPages = pagerImages.count
            setupScreens()

        scrollview.delegate = self
        
        self.view.bringSubviewToFront(pageControl)
        
       

        // Do any additional setup after loading the view.
        
        //print("phoneNumber = \(UserDefaults.standard.object(forKey: "phoneNumber") as! String)")
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    @objc func supportFunction(sender:UITapGestureRecognizer) {
        
        func printActionTitle(_ action: UIAlertAction) {
                   // print("You tapped \(action.title!)")
                   if action.title! == "Email"{
                    
                       
                   }
                   
                   if action.title! == "Call"{
                    if let url = URL(string: "tel://\("0242519130")"),
                    UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil
                    
                    )}
                   }
        }
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Email", style: .default, handler: printActionTitle))
        
        alertController.addAction(UIAlertAction(title: "Call", style: .default, handler: printActionTitle))
        // alertController.addAction(UIAlertAction(title: "Delete Account", style: .default, handler: printActionTitle))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: printActionTitle))
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    @objc func socialFunction(sender:UITapGestureRecognizer) {
        
    }
    
    @objc func invitesFunction(sender:UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "Invite Friends to YellowBus", message:
            "Friend's Phone Type", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "iOS", style: .default, handler: { (_) in
            
            //\n
                          
            let shareText = "Hey, let\'s join YellowBus, the Social Network for University Students \nhttps://apps.apple.com/us/app/minzter/id1473428585"
                                 
                                 if let image = UIImage(named: "yblogo2 copy") {
                                     let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
                                    self.present(vc, animated: true)
                                 }
                
                              
                              
        }))
        alertController.addAction(UIAlertAction(title: "Android", style: .default, handler: { (_) in
                          
            let shareText = "Hey, let\'s join YellowBus, the Social Network for University Students \nhttps://play.google.com/store/apps/details?id=dev.mintz.minzter"
                                 
                                 if let image = UIImage(named: "yblogo2 copy") {
                                     let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
                                    self.present(vc, animated: true)
                                 }
                
                              
                              
        }))
        
            self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func aboutFunction(sender:UITapGestureRecognizer) {
        
        let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        guard let aboutViewController = mainstoryboard.instantiateViewController(withIdentifier: "AboutViewController") as?
                AboutViewController else{
                
                return
        }
        
        
       self.navigationController?.pushViewController(aboutViewController, animated: true)
        
    }
    
    @objc func myticketsFunction(sender:UITapGestureRecognizer) {
        
        // Create a DatePicker
      /*         let datePicker: UIDatePicker = UIDatePicker()
               
               // Posiiton date picket within a view
               datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
               
               // Set some of UIDatePicker properties
               datePicker.timeZone = NSTimeZone.local
               datePicker.backgroundColor = UIColor.white
               
               // Add an event to call onDidChangeDate function when value is changed.
               datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged(_:)), for: .valueChanged)
          
               // Add DataPicker to the view
               self.view.addSubview(datePicker)*/
        
        
        
        
       
        
       
            let alertController = UIAlertController(title: "Select Date", message: nil, preferredStyle: .actionSheet)
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.date = Date()
        alertController.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 20).isActive = true
       // datePicker.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: 10).isActive = true
        datePicker.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 10).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: 0).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        datePicker.addTarget(self, action: #selector(StudentDashboardViewController.datePickerValueChanged(_:)), for: .valueChanged)
       
       
        
            alertController.view.translatesAutoresizingMaskIntoConstraints = false
            alertController.view.heightAnchor.constraint(equalToConstant: 220).isActive = true

          //  customView.backgroundColor = .green

            let selectAction = UIAlertAction(title: "Proceed", style: .default) { (action) in
                print("selection")
                
                if(self.selectedDate != ""){
                
                let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                guard let MyBookedSeatsViewController = mainstoryboard.instantiateViewController(withIdentifier: "MyBookedSeatsViewController") as?
                        MyBookedSeatsViewController else{
                        
                        return
                }
                
                    MyBookedSeatsViewController.date = self.selectedDate
                
                
               self.navigationController?.pushViewController(MyBookedSeatsViewController, animated: true)
            }
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func bookbusFunction(sender:UITapGestureRecognizer) {
        let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        guard let selectRouteViewController = mainstoryboard.instantiateViewController(withIdentifier: "SelectRouteViewController") as?
                SelectRouteViewController else{
                
                return
        }
        
        
       self.navigationController?.pushViewController(selectRouteViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    
   
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        
       // self.navigationItem.setHidesBackButton(true, animated: true)
      
       
        
        
           
       }

    
    func setupScreens() {
        for index in 0..<pagerImages.count {
            // 1.
            frame.origin.x = scrollview.frame.size.width * CGFloat(index)
            frame.size = scrollview.frame.size
            
            // 2.
           // let imgView = UIImageView(frame: frame)
            // imgView.image = pagerImages[index]
            let pagerImageView = UIImageView(frame: frame)
            pagerImageView.contentMode = .scaleAspectFit
            pagerImageView.image = pagerImages[index]

            self.scrollview.addSubview(pagerImageView)
        }

        // 3.
        scrollview.contentSize = CGSize(width: (scrollview.frame.size.width * CGFloat(pagerImages.count)), height: scrollview.frame.size.height)
        
        
        scrollview.delegate = self
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        
        
        
           
           // Create date formatter
           let dateFormatter: DateFormatter = DateFormatter()
           
           // Set date format
           dateFormatter.dateFormat = "E, d MMM yyyy"
           
           // Apply date format
        selectedDate = dateFormatter.string(from: sender.date)
           
           print("Selected value \(selectedDate)")
        
       
            
        
        
       }
    
    /*
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             
             
       
        
        if(indexPath.row == 0){
            
            let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
            guard let selectRouteViewController = mainstoryboard.instantiateViewController(withIdentifier: "SelectRouteViewController") as?
                    SelectRouteViewController else{
                    
                    return
            }
            
            
           self.navigationController?.pushViewController(selectRouteViewController, animated: true)
           
         //   bookSeatViewController.modalPresentationStyle = .fullScreen
      //  self.present(selectRouteViewController,animated: true,completion: nil)
            
            
        }
        
        if(indexPath.row == 1){
            
            // Create a DatePicker
          /*         let datePicker: UIDatePicker = UIDatePicker()
                   
                   // Posiiton date picket within a view
                   datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
                   
                   // Set some of UIDatePicker properties
                   datePicker.timeZone = NSTimeZone.local
                   datePicker.backgroundColor = UIColor.white
                   
                   // Add an event to call onDidChangeDate function when value is changed.
                   datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged(_:)), for: .valueChanged)
              
                   // Add DataPicker to the view
                   self.view.addSubview(datePicker)*/
            
            
            
            
           
            
           
                let alertController = UIAlertController(title: "Select Date", message: nil, preferredStyle: .actionSheet)
            let datePicker: UIDatePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePicker.Mode.date
            datePicker.date = Date()
            alertController.view.addSubview(datePicker)
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 20).isActive = true
           // datePicker.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: 10).isActive = true
            datePicker.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 10).isActive = true
            datePicker.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: 0).isActive = true
            datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
            datePicker.addTarget(self, action: #selector(StudentDashboardViewController.datePickerValueChanged(_:)), for: .valueChanged)
           
           
            
                alertController.view.translatesAutoresizingMaskIntoConstraints = false
                alertController.view.heightAnchor.constraint(equalToConstant: 220).isActive = true

              //  customView.backgroundColor = .green

                let selectAction = UIAlertAction(title: "Proceed", style: .default) { (action) in
                    print("selection")
                    
                    if(self.selectedDate != ""){
                    
                    let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                    guard let MyBookedSeatsViewController = mainstoryboard.instantiateViewController(withIdentifier: "MyBookedSeatsViewController") as?
                            MyBookedSeatsViewController else{
                            
                            return
                    }
                    
                        MyBookedSeatsViewController.date = self.selectedDate
                    
                    
                   self.navigationController?.pushViewController(MyBookedSeatsViewController, animated: true)
                }
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(selectAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            
            
        }
        
        if(indexPath.row == 2){
            
            if let url = URL(string: "tel://\("0270328905")"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil
            
            )}
            
        }
             
             
         /*    let title = (milestonesList?.text)!
             
             
             let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
             guard let awardsViewController = mainstoryboard.instantiateViewController(withIdentifier: "AwardsViewController") as?
                 AwardsViewController else{
                     
                     return
             }
             awardsViewController.awardtitle = title
        
             
             
            // self.navigationController?.pushViewController(awardsViewController, animated: true)
            
          //  awardsViewController.modalPresentationStyle = .fullScreen
            self.present(awardsViewController,animated: true,completion: nil)
 */
        
         }
    
    
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Configure the cell...
           
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StDashboardTableViewCell", for: indexPath)
        as! StDashboardTableViewCell
        
        cell.selectionStyle = .none
        
       // cell.optionImageView.layer.cornerRadius = 8
        
        cell.optionImageBackgroundView.layer.cornerRadius = 8
        
        
        
        if(indexPath.row == 0){
            cell.optionLabel.text = "Book Seat"
            cell.optionImageView.image = UIImage(systemName: "bus.fill"  )!
            cell.optionImageView.tintColor = UIColor.black
        }
        
        if(indexPath.row == 1){
            cell.optionLabel.text = "My Tickets"
            cell.optionImageView.image = #imageLiteral(resourceName: "ticket")
        }
        
        if(indexPath.row == 2){
             cell.optionLabel.text = "Contact YellowBus"
             cell.optionImageView.image = UIImage(systemName: "phone" )!
            cell.optionImageView.tintColor = UIColor.black
            // cell.optionImageView.image = #imageLiteral(resourceName: "cash")
         }
        
       /* if(indexPath.row == 2){
            cell.optionLabel.text = "Payment History"
            //cell.optionImageView.image = UIImage(systemName: "heart.circle.fill" )!
            cell.optionImageView.image = #imageLiteral(resourceName: "cash")
        }*/
        
       
        
        
        
        
        return cell
       }
    
    */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
