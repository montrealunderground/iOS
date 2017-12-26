//
//  LeftMenuViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import UIKit

public class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView?
    
    var balanceLabel: UILabel?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        let tableView: UITableView = UITableView.init(frame: CGRect(x: 0, y: (self.view.frame.size.height - (70 + 54 * 8)) / 2.0, width: self.view.frame.size.width, height:(70 + 54 * 8)), style: UITableViewStyle.plain)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isOpaque = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.bounces = false

        self.tableView = tableView
        self.view.addSubview(self.tableView!)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("LeftMenuViewController will appear")
        
        self.balanceLabel?.text = Constants.profileName + "\n" + NSLocalizedString("Balance", comment:"Balance") + ":" + Constants.profileBalance + " UC"
        //profileBalanceTextView.text = "Balance: " + Constants.profileBalance + " UC"
    }

    // MARK: - <UITableViewDelegate>

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0){
            self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.profileVC), animated: true)
            appDelegate.profileVC.hideBackButton(hidden: true)
            self.sideMenuViewController!.hideMenuViewController()
            
            appDelegate.onOpenVC(vc: appDelegate.profileVC)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            switch indexPath.row-1 {
                case 0:
                    appDelegate.homeVC.hideBackButton(hidden: true)
                    self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.homeVC), animated: true)
                    self.sideMenuViewController!.hideMenuViewController()
                    
                    appDelegate.onOpenVC(vc: appDelegate.homeVC)
                case 1:
                    
                    appDelegate.imagemapVC.hideBackButton(hidden: true)
                    self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.imagemapVC), animated: true)
                    self.sideMenuViewController!.hideMenuViewController()
                    
                    appDelegate.onOpenVC(vc: appDelegate.imagemapVC)
                case 2:
                    appDelegate.undergroundVC.destination = ""
                    appDelegate.undergroundVC.hideBackButton(hidden: true)
                    self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.undergroundVC), animated: true)
                    self.sideMenuViewController!.hideMenuViewController()
                    
                    appDelegate.onOpenVC(vc: appDelegate.undergroundVC)
                case 3:

                    appDelegate.metroVC.hideBackButton(hidden: true)
                    self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.metroVC), animated: true)
                    self.sideMenuViewController!.hideMenuViewController()
                    
                    appDelegate.onOpenVC(vc: appDelegate.metroVC)
                
                case 4:
            
                    appDelegate.profileVC.hideBackButton(hidden: true); self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.profileVC), animated: true)
                    self.sideMenuViewController!.hideMenuViewController()
                    
                    appDelegate.onOpenVC(vc: appDelegate.profileVC)
                case 5:
                    
                    appDelegate.ucstoreVC.hideBackButton(hidden: true)
                    self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.ucstoreVC), animated: true)
                    self.sideMenuViewController!.hideMenuViewController()
                    
                    appDelegate.onOpenVC(vc: appDelegate.ucstoreVC)
                case 6:
                    appDelegate.contactVC.hideBackButton(hidden: true)
                    self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: appDelegate.contactVC), animated: true)
                    self.sideMenuViewController!.hideMenuViewController()
                    
                    appDelegate.onOpenVC(vc: appDelegate.contactVC)
                default:
                    break
            }
        }
    }

    // MARK: - <UITableViewDataSource>

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 70
        } else {
            return 54
        }
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        return 8
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Constants.profileName
        //Constants.profileImgUrl
        let cellIdentifier: String = "Cell"

        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)

        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
            cell!.backgroundColor = UIColor.clear
            if (indexPath.row == 0) {
                cell!.textLabel?.font = UIFont.init(name: "HelveticaNeue", size: 19)
            } else {
                cell!.textLabel?.font = UIFont.init(name: "HelveticaNeue", size: 16)
            }
            cell!.textLabel?.textColor = UIColor.white
            cell!.textLabel?.highlightedTextColor = UIColor.white
            cell!.selectedBackgroundView = UIView.init()
        }
        
        var images: [String] = ["home-icon", "map3d-icon", "map-icon", "metro-icon", "profile-icon", "coins-icon",  "contactus-icon"/*"events-icon", "promo-icon", "facebook-outline", "feedback-icon", "contactus-icon"*/]
        if (indexPath.row != 0) {
            cell!.textLabel?.text = NSLocalizedString(Constants.titles[indexPath.row-1], comment: Constants.titles[indexPath.row-1])
                //NSLocalizedString(Constants.titles[indexPath.row], nil)
            cell!.imageView?.image = UIImage.init(named: images[indexPath.row-1])
        } else {
            let text:String! = Constants.profileName + "\nBalance:" + Constants.profileBalance + " UC"
            print(text)
            cell!.textLabel?.text = text
            cell!.textLabel?.lineBreakMode = .byWordWrapping
            cell!.textLabel?.numberOfLines = 2
            self.balanceLabel = cell!.textLabel
            //cell.imgView.af_setImage(withURL: URL(string: logo_filename)!)
            cell!.imageView?.image = UIImage.init(named: "avatar-1")
            cell!.imageView?.af_setImage(withURL: URL(string: Constants.profileImgUrl)!)
        }

        return cell!
    }
}
