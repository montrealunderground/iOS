//
//  RedeemViewController.swift
//  Montreal
//
//  Created by Eagle on 10/3/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import UIKit

class RedeemViewController: UITableViewController {

    var productData : NSMutableDictionary = [:]
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCostLabel: UILabel!
    @IBOutlet weak var productBalanceLabel: UILabel!
    
    @IBOutlet weak var customerNameText: UITextField!
    @IBOutlet weak var customerEmailText: UITextField!
    
    @IBOutlet weak var customerPhoneText: UITextField!
    @IBOutlet weak var customerAddressText: UITextField!
    @IBOutlet weak var customerCommentText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productImageView.af_setImage(withURL: URL(string: productData["imagename"] as! String)!)
        productNameLabel.text = (productData["name"] as! String)
        productCostLabel.text = (productData["price"] as! String) + "UC"
        productBalanceLabel.text = NSLocalizedString("Balance", comment:"balance") + ":" + Constants.profileBalance + " UC"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, error: String) {
        let alert = UIAlertController(
            title: title,
            message: error,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:"ok"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func onRedeem(_ sender: Any) {
        let name = customerNameText.text?.replacingOccurrences(of: " ", with: "")
        let email = customerEmailText.text?.replacingOccurrences(of: " ", with: "")
        let phone = customerPhoneText.text?.replacingOccurrences(of: " ", with: "")
        let address = customerAddressText.text?.replacingOccurrences(of: " ", with: "")
        let comments = customerCommentText.text?.replacingOccurrences(of: " ", with: "")
        if (name?.characters.count == 0) {
            self.showAlert(title: "Form Error", error: "Name is required")
            return
        }
        if (email?.characters.count == 0) {
            self.showAlert(title: "Form Error", error: "Email is required")
            return
        }
        if (phone?.characters.count == 0) {
            self.showAlert(title: "Form Error", error: "Phone is required")
            return
        }
        if (address?.characters.count == 0) {
            self.showAlert(title: "Form Error", error: "Address is required")
            return
        }
        
        NetworkManger.sharedInstance.purchaseItem(userid: Constants.profileUserId, ucitemid: self.productData["id"] as! String) { (json, status) in
            let result = json["result"] as! String
            print(json)
            if result == "success"{
                Constants.profileBalance = json["undercoin"] as! String
                self.showAlert(title: String.init(format: NSLocalizedString("You have redeemed %@", comment:"redeemtitle"), self.productData["name"] as! String) , error: NSLocalizedString("Redeem Success!", comment:"redeemmessage"))
            } else {
                self.showAlert(title: "Redeem Failed", error: NSLocalizedString("Redeem Failed!", comment:"redeemmessage"))
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
