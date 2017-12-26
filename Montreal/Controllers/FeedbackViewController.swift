//
//  FeedbackViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
import MessageUI
public class FeedbackViewController: AdViewController,MFMailComposeViewControllerDelegate {
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("FeedbackViewController awake from nib")
    }
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let borderColor = UIColor.init(colorLiteralRed: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        
        
        txtMessage.layer.borderColor = borderColor.cgColor
        txtMessage.layer.borderWidth = 1.0
        txtMessage.layer.cornerRadius = 5.0
        txtMessage.layer.cornerRadius = 5.0
    }
    public override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func submitAction(_ sender: Any) {
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["someemail@gmail.com"])
            mail.setSubject(NSLocalizedString("Subject", comment: "Subject"))
            mail.setMessageBody(NSLocalizedString("Some Text", comment: "Some Text"), isHTML: false)
            self.present(mail, animated: true, completion: nil)
        }
    }
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
