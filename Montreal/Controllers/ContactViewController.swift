//
//  ContactViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
import MessageUI
public class ContactViewController: AdViewController,MFMailComposeViewControllerDelegate {
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("ContactViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func emailAction(_ sender: Any) {
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["someemail@gmail.com"])
            mail.setSubject(NSLocalizedString("Subject", comment: "Subject"))
            mail.setMessageBody(NSLocalizedString("Some Text", comment: "Quelques textes"), isHTML: false)
            self.present(mail, animated: true, completion: nil)
        }
    }
    @IBAction func callAction(_ sender: Any) {
        //tel:+1514 292-5151
        guard let number = URL(string: "telprompt://" + "15142925151") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    @IBAction func facebookAction(_ sender: Any) {
        //https://www.facebook.com/MontrealSouterrain/
        guard let number = URL(string: "https://www.facebook.com/MontrealSouterrain/") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    @IBAction func twitterAction(_ sender: Any) {
        //https://twitter.com/MTL_Souterrain
        guard let number = URL(string: "https://twitter.com/MTL_Souterrain") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    @IBAction func linkedInAction(_ sender: Any) {
        //https://www.linkedin.com/company/montreal-souterrain
        guard let number = URL(string: "https://www.linkedin.com/company/montreal-souterrain") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
