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
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(bitcoinURL).responseJSON{
            response in
            if response.result.isSuccess{
                print(response)
            } else {
                print("Error \(String(describing: response.result.error))")
                self.connectionErrorAlert()
            }
        }
    }
    
    func connectionErrorAlert(){
        let alert = UIAlertController(title: "Error!", message: "Connection Error! Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { (action) in
            self.errorLabel.text = "Connection Error! Please try again."
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

}

