//
//  RightMenuViewController.swift
//  AKSideMenuSimple
//
//  Created by Diogo Autilio on 6/7/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

public class RightMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {

    var tableView: UITableView?
    var interstitial: GADInterstitial!

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override func awakeFromNib() {
        super.awakeFromNib()
        createAndLoadInterstitial()
        print("RightMenuViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()

        let tableView: UITableView = UITableView.init(frame: CGRect(x: 240, y: 180, width: self.view.frame.size.width-240, height: self.view.frame.size.height-180), style: UITableViewStyle.plain)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isOpaque = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.bounces = false
        tableView.scrollsToTop = false

        self.tableView = tableView
        self.view.addSubview(self.tableView!)
    }

    // MARK: - <UITableViewDelegate>

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        let rentFormVC = self.storyboard?.instantiateViewController(withIdentifier: "rentFormViewController") as! RentFormViewController
        //configureBackButton()
        switch indexPath.row {
        case 0:
            rentFormVC.url = "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8"
            break
        case 1:
            rentFormVC.url = "https://twitter.com/intent/tweet?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&text=Download%20Montreal%20Underground%20App"
            break
        case 2:
            rentFormVC.url = "https://plus.google.com/share?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8"
            break
        case 3:
            rentFormVC.url = "http://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&title=Download%20Montreal%20Underground%20App"
            break
        case 4:
            rentFormVC.url = "http://pinterest.com/pin/create/button/?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&media=&description=Download%20Montreal%20Underground%20App"
            break
        case 5:
            if MFMailComposeViewController.canSendMail()
            {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["someemail@gmail.com"])
                mail.setSubject("Subject")
                mail.setMessageBody("Some Text", isHTML: false)
                self.present(mail, animated: true, completion: nil)
            }
            break
        default:
            break
        }
        self.navigationController?.pushViewController(rentFormVC, animated: true)
//        switch indexPath.row {
//        case 0:
//            guard let number = URL(string: "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8") else { return }
//            UIApplication.shared.open(number, options: [:], completionHandler: nil)
//            break
//        case 1:
//            guard let number = URL(string: "https://twitter.com/intent/tweet?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&text=Download%20Montreal%20Underground%20App") else { return }
//            UIApplication.shared.open(number, options: [:], completionHandler: nil)
//            
//            break
//        case 2:
//            guard let number = URL(string: "https://plus.google.com/share?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8") else { return }
//            UIApplication.shared.open(number, options: [:], completionHandler: nil)
//            
//            break
//        case 3:
//            guard let number = URL(string: "http://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&title=Download%20Montreal%20Underground%20App") else { return }
//            UIApplication.shared.open(number, options: [:], completionHandler: nil)
//            
//            break
//        case 4:
//            guard let number = URL(string: "http://pinterest.com/pin/create/button/?url=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fmontreal-underground%2Fid1175238440%3Fls%3D1%26mt%3D8&media=&description=Download%20Montreal%20Underground%20App") else { return }
//            UIApplication.shared.open(number, options: [:], completionHandler: nil)
//            break
//        case 5:
//            if MFMailComposeViewController.canSendMail()
//            {
//                let mail = MFMailComposeViewController()
//                mail.mailComposeDelegate = self
//                mail.setToRecipients(["someemail@gmail.com"])
//                mail.setSubject("Subject")
//                mail.setMessageBody("Some Text", isHTML: false)
//                self.present(mail, animated: true, completion: nil)
//            }
//            break
//        default:
//            break
//        }
    }

    // MARK: - <UITableViewDataSource>

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        return 6
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "Cell"

        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)

        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
            cell!.backgroundColor = UIColor.clear
            cell!.textLabel?.font = UIFont.init(name: "HelveticaNeue", size: 21)
            cell!.textLabel?.textColor = UIColor.white
            cell!.textLabel?.highlightedTextColor = UIColor.lightGray
            cell!.selectedBackgroundView = UIView.init()
        }
        switch indexPath.row {
        case 0:
            cell!.imageView?.image = UIImage(named: "facebook")
            break
        case 1:
            cell!.imageView?.image = UIImage(named: "linkedin")
            break
        case 2:
            cell!.imageView?.image = UIImage(named: "twitter")
            break
        case 3:
            cell!.imageView?.image = UIImage(named: "google-plus")
            break
        case 4:
            cell!.imageView?.image = UIImage(named: "pinterest")
            break
        case 5:
            cell!.imageView?.image = UIImage(named: "email")
            break
        default:
            break
        }
        
        return cell!
    }
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
    }
}
