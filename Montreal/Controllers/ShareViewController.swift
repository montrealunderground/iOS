//
//  ShareViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import UIKit
import MessageUI
import FBSDKShareKit

public class ShareViewController: UIViewController,MFMailComposeViewControllerDelegate {
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("ShareViewController awake from nib")
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
    
//    @IBAction func pinterestAction(_ sender: Any) {
//        guard let number = URL(string: "http://pinterest.com/pin/create/button/?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&media=&description=Download%20Montreal%20Underground%20App") else { return }
//        UIApplication.shared.open(number, options: [:], completionHandler: nil)
//    }
//    
//    @IBAction func linkedInAction(_ sender: Any) {
//        guard let number = URL(string: "http://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&title=Download%20Montreal%20Underground%20App") else { return }
//        UIApplication.shared.open(number, options: [:], completionHandler: nil)
//    }
    
    @IBAction func gplusAction(_ sender: Any) {
//        self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.homeVC), animated: true)
//        appDelegate.homeVC.hideBackButton(hidden: true)
//        appDelegate.homeVC.showgpShareDialog()
//        self.sideMenuViewController!.hideMenuViewController()
//        
        self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.currentVC!), animated: true)
        self.sideMenuViewController!.hideMenuViewController()
        appDelegate.currentVC?.showgpShareDialog(content: "https://montrealundergroundcity.com", isURL: true)
//        guard let number = URL(string: "https://plus.google.com/share?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8") else { return }
//        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    @IBAction func twitterAction(_ sender: Any) {
//        self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.homeVC), animated: true)
//        appDelegate.homeVC.hideBackButton(hidden: true)
//        appDelegate.homeVC.showtwShareDialog()
//        self.sideMenuViewController!.hideMenuViewController()

        self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.currentVC!), animated: true)
        self.sideMenuViewController!.hideMenuViewController()
        appDelegate.currentVC?.showtwShareDialog(content: "http://montrealundergroundcity.com", isURL: true)

//        guard let number = URL(string: "https://twitter.com/intent/tweet?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&text=Download%20Montreal%20Underground%20App") else { return }
//        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        //guard let number = URL(string: "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8") else { return }
        //UIApplication.shared.open(number, options: [:], completionHandler: nil)
        
//        self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.homeVC), animated: true)
//        appDelegate.homeVC.hideBackButton(hidden: true)
//        appDelegate.homeVC.showfbShareDialog()
        
        self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.currentVC!), animated: true)
        self.sideMenuViewController!.hideMenuViewController()
        
        appDelegate.currentVC?.showfbShareDialog(content: "http://montrealundergroundcity.com", isURL: true)
        
        //FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        //content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
        
        //FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
        //dialog.fromViewController = self;
        //dialog.content = content;
        //dialog.mode = FBSDKShareDialogModeShareSheet;
        //[dialog show];
    }
    
    //    public func configureBackButton() {
    //        let backItem = UIBarButtonItem()
    //        backItem.title = ""
    //        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    //    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        if (result == .sent) {
            self.onShareSuccess("Email")
        }
    }
}
