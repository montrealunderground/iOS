//
//  UIViewController+AKSideMenu.swift
//  AKSideMenu
//
//  Created by Diogo Autilio on 6/3/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import UIKit

import FBSDKShareKit
import Fabric
import TwitterKit
import SafariServices

// MARK: - UIViewController+AKSideMenu

extension UIViewController : SearchViewControllerDelegate, FBSDKSharingDelegate, SFSafariViewControllerDelegate, GPPShareDelegate {
    
    public var sideMenuViewController: AKSideMenu? {
        get {
            var iter: UIViewController = self.parent!
            let strClass = String(describing: type(of: iter)).components(separatedBy: ".").last!
            while strClass != nibName {
                if iter is AKSideMenu {
                    return iter as? AKSideMenu
                } else if iter.parent != nil && iter.parent != iter {
                    iter = iter.parent!
                }
            }
            return nil
        }
        set(newValue) {
            self.sideMenuViewController = newValue
        }
    }
    
    public func showfbShareDialog(content: String, isURL: Bool) {
        let contentObj : FBSDKShareLinkContent = FBSDKShareLinkContent()
        if isURL {
            contentObj.contentURL = URL(string: content)!
        } else {
            contentObj.quote = content
        }
        //
        //        let photo : FBSDKSharePhoto = FBSDKSharePhoto()
        //        photo.image = UIImage(named:"logo")
        //        photo.isUserGenerated = true
        //        let photocontent: FBSDKSharePhotoContent = FBSDKSharePhotoContent()
        //        photocontent.photos = [photo]
        let dlg : FBSDKShareDialog = FBSDKShareDialog()
        dlg.fromViewController = self
        dlg.shareContent = contentObj
        dlg.mode = .native
        dlg.delegate = self
        dlg.show()
    }
    
    public func showtwShareDialog(content: String, isURL: Bool) {
        let composer = TWTRComposer()
        
        if isURL {
            composer.setURL(URL(string: content)!)
        } else {
            composer.setText(content)
        }
        //composer.setImage(UIImage(named: "fabric"))
        
        // Called from a UIViewController
        composer.show(from: self) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
            }
            else if (result == TWTRComposerResult.done) {
                print("Tweet composition success")
                self.onShareSuccess("Twitter")
            }
        }
    }
    
    public func showgpShareDialog(content: String, isURL: Bool) {
        var urlComponents : URLComponents = URLComponents(string:"https://plus.google.com/share")!
        if (isURL) {
            urlComponents.queryItems = [URLQueryItem(name:"url", value:content)]
        } else {
            urlComponents.queryItems = [URLQueryItem(name:"text", value:content)]
        }
        
        let url = urlComponents.url
        let controller = SFSafariViewController(url:url!)
        controller.delegate = self
        self.present(controller, animated:true, completion:nil)
    }
    
    public func onShareSuccess(_ shareName: String) {
        NetworkManger.sharedInstance.sharedApplication(userid: Constants.profileUserId) { (json, status) in
            let result = json["result"] as! String
            print(json)
            if result == "success"{
                Constants.profileBalance = json["undercoin"] as! String
                appDelegate.profileVC.updateBalance()
                self.showShareSuccessDialog(socialname: shareName)
            }
        }
    }
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        print("safariViewControllerDidFinish")
        self.onShareSuccess("Google Plus")
    }
    
    public func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print("didCompleteWithResults")
        self.onShareSuccess("Facebook")
    }
    
    func showShareSuccessDialog(socialname:String!) {
        let alert = UIAlertController(title: "Posted on "+socialname, message: "You got 3 free coins for posting on "+socialname+".", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Sent to the delegate when the sharer encounters an error.
     - Parameter sharer: The FBSDKSharing that completed.
     - Parameter error: The error.
     */
    public func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
//        if ( fbloginstate == 0 ) {
        print(error)
            let alert = UIAlertController(title: "Facebook Post failed", message:"You do have to Sign in Facebook to post.", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: /*"prefs:root=FACEBOOK"*/UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        
                    })
                }
            }
            alert.addAction(settingsAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
//        }
//        fbloginstate = 0
    }
    /**
     Sent to the delegate when the sharer is cancelled.
     - Parameter sharer: The FBSDKSharing that completed.
     */
    public func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print("sharerDidCancel")
        //fbloginstate = 0
    }


    // MARK: - Public
    // MARK: - IB Action Helper methods
    @IBAction public func presentSearchViewController(_ sender: AnyObject) {
        //self.addChildViewController(appDelegate.searchVC)
        
        appDelegate.searchVC.delegate = self
        //appDelegate.searchVC.searchBar.text = ""
        appDelegate.window?.addSubview(appDelegate.searchVC.view)
        //self.view.addSubview(appDelegate.searchVC.view)
        //self.navigationController?.pushViewController(appDelegate.searchVC, animated: false)
    }
    @IBAction public func presentLeftMenuViewController(_ sender: AnyObject) {
        self.sideMenuViewController!.presentLeftMenuViewController()
    }

    @IBAction public func presentRightMenuViewController(_ sender: AnyObject) {
        self.sideMenuViewController!.presentRightMenuViewController()
    }
    
    @IBAction public func popBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func hideBackButton(hidden: Bool) {
        if (self.navigationItem.leftBarButtonItems == nil || (self.navigationItem.leftBarButtonItems?.count)! <= 1) {
            return
        }
        
        var back:UIBarButtonItem!
        var menu:UIBarButtonItem!
        if (self.navigationItem.leftBarButtonItems?[0].tag == 1) {
            back = self.navigationItem.leftBarButtonItems?[0]
            menu = self.navigationItem.leftBarButtonItems?[1]
        } else {
            back = self.navigationItem.leftBarButtonItems?[1]
            menu = self.navigationItem.leftBarButtonItems?[0]
        }
        
        if (hidden) {
            back.tintColor = UIColor.clear
            
            self.navigationItem.leftBarButtonItems?[0] = menu
            self.navigationItem.leftBarButtonItems?[1] = back
        }
        else {
            back.tintColor = UIColor.darkGray
            
            self.navigationItem.leftBarButtonItems?[0] = back
            self.navigationItem.leftBarButtonItems?[1] = menu
        }
    }
    
    public func showPlaceDetailViewController(place: NSDictionary) {
        let featured = place["featured"] as! String
        if (featured == "0") {
            let placeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "placeDetailViewController") as! PlaceDetailViewController
            placeDetailVC.isFromSearch = true
            placeDetailVC.place = place
            placeDetailVC.baseimageurl = ""
            self.navigationController?.pushViewController(placeDetailVC, animated: true)
        } else {
            let placeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "featuredPlaceViewController") as! FeaturedPlaceViewController
            placeDetailVC.isFromSearch = true
            placeDetailVC.store = place
            placeDetailVC.coverphotobaseURL = ""
            self.navigationController?.pushViewController(placeDetailVC, animated: true)
        }
    }
    
    public func showWebViewController(title:String, link:String) {
        let searchResultViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchResultViewController") as! SearchResultViewController
        searchResultViewController.url = link
        searchResultViewController.storename = title
        //configureBackButton()
        
        self.navigationController?.pushViewController(searchResultViewController, animated: true)
    }
    
}
