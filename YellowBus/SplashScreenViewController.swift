//
//  SplashScreenViewController.swift
//  YellowBus
//
//  Created by mac on 02/08/2021.
//

import UIKit
import Firebase
import GoogleSignIn

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var logoImgView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        logoImgView.layer.cornerRadius = logoImgView.frame.size.width / 2
        // Do any additional setup after loading the view.
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func  viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
        
          DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
                            DispatchQueue.main.async {
                                
                                let defaults = UserDefaults.standard
                                
                            //user signed up
                                if let _ = defaults.string(forKey: "loggedIn"){
                                
                                //firebase uses keychain to keep app logged in
                                //even after deleting
                                if(Auth.auth().currentUser?.uid != nil){
                               
                                    
                                    
                                    let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                                    guard let studentDashboardViewController = mainstoryboard.instantiateViewController(withIdentifier: "StudentDashboardViewController") as?
                                            StudentDashboardViewController else{
                                            
                                            return
                                    }
                                
                                    
                                    self.navigationController?.pushViewController(studentDashboardViewController, animated: true)
                                   
                                //    studentDashboardViewController.modalPresentationStyle = .fullScreen
                              //     self.present(studentDashboardViewController,animated: true,completion: nil)

                                    // Your user is signed in!
                                
                                }else{
                                    let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                                    guard let signInViewController = mainstoryboard.instantiateViewController(withIdentifier: "SignInViewController") as?
                                            SignInViewController else{
                                            
                                            return
                                    }
                                
                                    
                                   // self.navigationController?.pushViewController(awardsViewController, animated: true)
                                   
                                 //  awardsViewController.modalPresentationStyle = .fullScreen
                                    self.navigationController?.pushViewController(signInViewController, animated: true)
                                }
                                }else{
                                    let mainstoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
                                    guard let signInViewController = mainstoryboard.instantiateViewController(withIdentifier: "SignInViewController") as?
                                            SignInViewController else{
                                            
                                            return
                                    }
                                
                                    
                                   // self.navigationController?.pushViewController(awardsViewController, animated: true)
                                   
                                 //  awardsViewController.modalPresentationStyle = .fullScreen
                                    self.navigationController?.pushViewController(signInViewController, animated: true)
                                }
                            }
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

}
