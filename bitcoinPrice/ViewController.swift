//
//  ViewController.swift
//  bitcoinPrice
//
//  Created by Greg Haranczyk on 1/28/18.
//  Copyright © 2018 Greg Haranczyk. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    let bitcoinURL = "https://api.coindesk.com/v2/bpi/currentprice.json"
    
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        webServiceRequest(urlString: bitcoinURL)
    }
    
    func webServiceRequest(urlString: String){
        Alamofire.request(urlString).responseJSON{
            response in
            if response.result.isSuccess{
                print(response)
                self.parseJSON(data: response)
            } else {
                print("Error \(String(describing: response.result.error))")
                self.connectionErrorAlert(data: response)
            }
        }
    }
    
    func parseJSON(data: DataResponse<Any>) {
        let bitcoinJSON = data.result.value
        let bitcoinObject: Dictionary = bitcoinJSON as! Dictionary<String, Any>
        let bpiObject: Dictionary = bitcoinObject["bpi"] as! Dictionary<String, Any>
        let usdObject: Dictionary = bpiObject["USD"] as! Dictionary<String, Any>
        let rate: Float = usdObject["rate_float"] as! Float
        
        let usdRateString = "$" + String(format: "%.2f", rate)
        priceLabel.text = usdRateString
        errorLabel.text = ""
    }
    
    func connectionErrorAlert(data: DataResponse<Any>){
        let alert = UIAlertController(title: "Error!", message: "Connection Error! Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { (action) in
            self.errorLabel.text = "Connection Error! Please try again."
            self.webServiceRequest(urlString: self.bitcoinURL)
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in
            self.errorLabel.text = "Connection Error! Please try again."}))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        webServiceRequest(urlString: bitcoinURL)
    }
    
}

