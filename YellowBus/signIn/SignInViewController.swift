//
//  SignInViewController.swift
//  YellowBus
//
//  Created by mac on 02/08/2021.
//

import UIKit
import GoogleSignIn
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var logoImgView: UIImageView!
    
    @IBOutlet weak var editName: UITextField!
    
    @IBOutlet weak var editPhoneNumber: UITextField!
    
    var name = ""
    var loadalertController = UIAlertController()
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImgView.layer.cornerRadius = logoImgView.frame.size.width / 2
        

        // Do any additional setup after loading the view.
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    
    func signIn(){
        
        if (editName.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Enter Username", message:
                "Please Enter Username", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        if (editPhoneNumber.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Enter Phone Number", message:
                "Please Enter Phone Number", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
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
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    
                    DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                      DispatchQueue.main.async {
                        self.loadalertController.dismiss(animated: true, completion :{
                            let logoutAlertController = UIAlertController(title: "Sign In Error", message:
                                                                            "Failed to Sign In", preferredStyle: .alert)
                           // logoutAlertController.addAction(UIAlertAction(title: "", style: .default, handler: confirmUnfollow))
                            logoutAlertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                            
                            self.present(logoutAlertController, animated: true, completion: nil)
                            
                            })
                        
                   
                        
                      }})
                    
                    
                  let authError = error as NSError
                  
                  return
                }
                 print("User is signed in")
                // ...
                
             /*   SharedPrefManager.getInstance(signIn.this).storeUser_Type(usertype);
                                               SharedPrefManager.getInstance(signIn.this).storeName(name);
                                               SharedPrefManager.getInstance(signIn.this).storePhoneNumber(phoneNumber);

                                               users_model newuser = new users_model(name,phoneNumber,user_id,sName, "0", "0");

                                               usersCountDb.child(user_id).setValue(true);
                                               usersDb.child(user_id).setValue(newuser);
                 
                 public users_model(String name,String phone,String uid,String sName,String bkngs,String acctbal) {
                 
                 usersCountDb.child(user_id).setValue(true);
                                                usersDb.child(user_id).setValue(newuser);
                    
                 */
                
                let userID  = Auth.auth().currentUser?.uid
                
                name = editName.text!
                phoneNumber = editPhoneNumber.text!

                
                UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                UserDefaults.standard.set(name, forKey: "name")
                UserDefaults.standard.set(true, forKey: "loggedIn")
                
                let str = name.lowercased()
                let pattern = "[^A-Za-z0-9]+"
                let searchName = str.replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
                
                let newUser : [String:Any] = ["name":name,"phone":phoneNumber,"uid":userID!,"sName":searchName,"bkngs":"0","acctbal":"0"]
                
                
                let usersDb = Database.database().reference().child("users")
                let usersCountDb = Database.database().reference().child("users_count")
                
                usersCountDb.child(userID!).setValue(true);
                usersDb.child(userID!).setValue(newUser);
                
                DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                  DispatchQueue.main.async {
                    self.loadalertController.dismiss(animated: true, completion :{
                        
                        let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                        guard let studentDashboardViewController = mainstoryboard.instantiateViewController(withIdentifier: "StudentDashboardViewController") as?
                                StudentDashboardViewController else{
                                
                                return
                        }
                    
                        
                        self.navigationController?.pushViewController(studentDashboardViewController, animated: true)
                        })
                    
               
                    
                  }})

                
                
                
                
            }

          // ...
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func signInAction(_ sender: GIDSignInButton) {
        signIn()
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
