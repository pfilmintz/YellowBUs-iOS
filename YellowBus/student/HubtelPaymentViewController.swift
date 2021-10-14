//
//  HubtelPaymentViewController.swift
//  YellowBus
//
//  Created by mac on 14/09/2021.
//

import UIKit
import WebKit

class HubtelPaymentViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var webView: WKWebView!
    
    var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:url)
              let myRequest = URLRequest(url: myURL!)
              webView.load(myRequest)

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
          let webConfiguration = WKWebViewConfiguration()
          webView = WKWebView(frame: .zero, configuration: webConfiguration)
          webView.uiDelegate = self
          view = webView
       }
    
    
    @IBAction func cancelBarBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBarBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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
