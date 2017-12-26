//
//  MallDetailsViewController.swift
//  Montreal
//
//  Created by William Andersson on 3/14/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import UIKit

import GoogleMobileAds
import AudioToolbox

class FeaturedPlaceViewController : UITableViewController ,GADBannerViewDelegate {
    
    var adMobBannerView: GADBannerView?
    
    var store : NSDictionary = [:]
    var isFromSearch : Bool = false
    var baseURL : String = ""
    var coverphotobaseURL : String = ""
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("FeaturedPlaceViewController awake from nib")
    }
    
    
    @IBOutlet weak var malllogoImage: UIImageView!
    @IBOutlet weak var storenameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mallLabel: UILabel!
    @IBOutlet weak var metroLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    
    @IBAction func contactAction(_ sender: Any) {
        print(store["contact"] ?? "")
        let contact = store["contact"] as! String
        guard let number = URL(string: "telprompt://" + contact) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        print(store["facebook"] ?? "")
        let facebook = store["facebook"] as! String
        let rentFormVC = self.storyboard?.instantiateViewController(withIdentifier: "rentFormViewController") as! RentFormViewController
        rentFormVC.titlename = (store["name"] as? String)!
        rentFormVC.url = facebook
        configureBackButton()
        self.navigationController?.pushViewController(rentFormVC, animated: true)
    }
    
    @IBAction func websiteAction(_ sender: Any) {
        print(store["link"] ?? "")
        let facebook = store["link"] as! String
        let rentFormVC = self.storyboard?.instantiateViewController(withIdentifier: "rentFormViewController") as! RentFormViewController
        rentFormVC.titlename = (store["name"] as? String)!
        rentFormVC.url = facebook
        configureBackButton()
        self.navigationController?.pushViewController(rentFormVC, animated: true)
    }
    
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init AdMob banner
        initAdMobBanner()

        // Do any additional setup after loading the view, typically from a nib.
        title = store["name"] as? String
        configureData()
        self.tableView.separatorColor = UIColor.clear;
    }
    
    func configureData(){
        print(store)
        print(self.baseURL)
        var img_link:String!
        if self.isFromSearch {
            img_link = store["coverphotourl"] as! String
        } else {
            img_link = store["coverphoto_filename"] as! String
            img_link = self.coverphotobaseURL + img_link
        }
        malllogoImage.af_setImage(withURL: URL(string: img_link)!)
        
        storenameLabel.text = store["name"] as? String
        typeLabel.text = store["type"] as? String
        mallLabel.text = store["mallname"] as? String
        metroLabel.text = store["metroname"] as? String
        aboutLabel.text = store["aboutus"] as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.row) {
        case 0:
            return 250
        case 1:
            return 142
        case 2:
            return 100
        case 3:
            return 74
        case 4:
            aboutLabel.frame = CGRect(x:0, y:0, width:tableView.frame.width, height:CGFloat.greatestFiniteMagnitude)
            aboutLabel.numberOfLines = 0
            aboutLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            aboutLabel.text = (store["aboutus"] as? String)! + "\n\n\n\n\n"
            aboutLabel.sizeToFit()
            return aboutLabel.frame.height
        default:
            return 0
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
        NSLog("FeaturedPlaceViewController will appear")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
        NSLog("FeaturedPlaceViewController will disappear")
    }
    
    // MARK: -  ADMOB BANNER
    func initAdMobBanner() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView?.adSize =  GADAdSizeFromCGSize(CGSize(width: 320 , height: 50))
            adMobBannerView?.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
        } else  {
            // iPad
            adMobBannerView?.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
            adMobBannerView?.frame = CGRect(x: 0, y: view.frame.size.height, width: 468, height: 60)
        }
        
        adMobBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adMobBannerView?.adUnitID = NSLocalizedString(Constants.BANNER_ADS_UNIT_ID, comment: "")
        adMobBannerView?.delegate = self
        adMobBannerView?.rootViewController = self
        
        let request = GADRequest()
        adMobBannerView?.load(request)
    }
    
    // Hide the banner
    func hideBanner(_ banner: UIView) {
        UIView.beginAnimations("hideBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = true
    }
    
    // Show the banner
    func showBanner(_ banner: UIView) {
        self.navigationController?.toolbar.addSubview(adMobBannerView!)
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView!) {
        showBanner(adMobBannerView!)
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        hideBanner(adMobBannerView!)
    }
    
    @IBAction func onFacebookShare(_ sender: Any) {
        self.showfbShareDialog(content: (store["name"] as? String)!, isURL: false)
    }
    @IBAction func onTwitterShare(_ sender: Any) {
        self.showtwShareDialog(content: (store["name"] as? String)!, isURL: false)
    }
    @IBAction func onGpShare(_ sender: Any) {
        self.showgpShareDialog(content: (store["name"] as? String)!, isURL: false)
    }
}

