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

class MallDetailsViewController: UITableViewController ,GADBannerViewDelegate {
    
    var adMobBannerView: GADBannerView?
    
    var mall : NSDictionary = [:]
    var baseURL : String = ""
    var promotionBaseURL : String = ""
    var latitude : String = "", longitude : String = ""
    var promotions : [NSDictionary] = []
    var infos: NSDictionary = [:]
    var places : [PlaceOfInterest] = []
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("MallDetailsViewController awake from nib")
    }
    
    
    @IBOutlet weak var malllogoImage: UIImageView!
    @IBOutlet weak var mallname: UILabel!
    @IBOutlet weak var infoCollectionview: UICollectionView!
    
    @IBOutlet weak var workinghourslabel: UILabel!
    var allPlaceViewController = PlaceListViewController()
    
    @IBOutlet weak var aboutuslabel: UILabel!
    @IBAction func arAction(_ sender: Any) {
//        let arVC = self.storyboard?.instantiateViewController(withIdentifier: "arViewController") as! AugmentedViewController
//        arVC.places = self.places
//        arVC.title = self.title
//        arVC.delegate = self
//        configureBackButton()
//        self.navigationController?.pushViewController(arVC, animated: true)
    }
    
    @IBAction func storeAction(_ sender: Any) {
        allPlaceViewController = self.storyboard?.instantiateViewController(withIdentifier: "placeListViewController") as! PlaceListViewController
        NetworkManger.sharedInstance.getStoresAPI(parameters: ["mallid":(mall["id"] as! String!)]) { (json, status) in
            print(json)
            let stores = json["stores"] as! [NSDictionary]
            self.allPlaceViewController.list = stores
            self.allPlaceViewController.mode = .Stores
            self.allPlaceViewController.baseURL = json["download_prefix_store"] as! String
            self.allPlaceViewController.coverphotoURL = json["download_prefix_store_coverphoto"] as! String
            self.allPlaceViewController.title = self.title
            self.configureBackButton()
            self.navigationController?.pushViewController(self.allPlaceViewController, animated: true)
        }
    }
    @IBAction func locationAction(_ sender: Any) {
        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "locationViewController") as! LocationViewController
        //locationVC.location = self.location
        locationVC.latitude = self.latitude
        locationVC.longitude = self.longitude
        locationVC.title = self.title
        configureBackButton()
        self.navigationController?.pushViewController(locationVC, animated: true)
    }
    @IBAction func mapAction(_ sender: Any) {
        configureBackButton()
        appDelegate.undergroundVC.destination = mall["mapposition"] as! String
        appDelegate.undergroundVC.title = self.title
        self.navigationController?.pushViewController(appDelegate.undergroundVC, animated: true)
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
        title = mall["name"] as? String
        configureData()
        self.tableView.separatorColor = UIColor.clear;
        infoCollectionview.delegate = self
        infoCollectionview.dataSource = self
    }
    
    func onGotoStore(_ promotiontitle: String!, latitude: String!, longitude: String!) {
        print("ongotostore")
        
        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "locationViewController") as! LocationViewController
        locationVC.latitude = latitude
        locationVC.longitude = longitude
        locationVC.title = promotiontitle
        configureBackButton()
        self.navigationController?.pushViewController(locationVC, animated: true)
    }
    
    func configureData(){
        print(mall)
        print(self.baseURL)
        mallname.text = mall["name"] as? String
        var img_link = mall["coverphoto_filename"] as! String
        img_link = baseURL + img_link
        malllogoImage.af_setImage(withURL: URL(string: img_link)!)
        workinghourslabel.text = mall["workinghours"] as? String
        aboutuslabel.text = mall["aboutus"] as? String
        latitude = (mall["latitude"] as? String!)!
        longitude = (mall["longitude"] as? String!)!
        //location = (mall["contact"] as? String)!
        let info = mall["info"] as! String
        do{
            infos = try JSONSerialization.jsonObject(with: info.data(using: .utf8)!, options: []) as! NSDictionary
        }catch{
            print("Error Parsing JSON from register_user_v2")
        }
        promotions = mall["promotions"] as! [NSDictionary]
        promotionsToPOI()
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
            return 50
        case 2:
            var rows:Int = Int(infos.count/3)
            if infos.count % 3 != 0 {
                rows = rows+1
            }
            print(rows)
            return CGFloat(70 * rows)
        case 3:
            return 100
            //return 150
        case 4:
            workinghourslabel.frame = CGRect(x:0, y:0, width:tableView.frame.width, height:CGFloat.greatestFiniteMagnitude)
            workinghourslabel.numberOfLines = 0
            workinghourslabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            workinghourslabel.text = (mall["workinghours"] as? String)!/* + "\n\n\n"*/
            workinghourslabel.sizeToFit()
            return workinghourslabel.frame.height
        case 5:
            aboutuslabel.frame = CGRect(x:0, y:0, width:tableView.frame.width, height:CGFloat.greatestFiniteMagnitude)
            aboutuslabel.numberOfLines = 0
            aboutuslabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            aboutuslabel.text = (mall["aboutus"] as? String)! + "\n\n\n\n\n"
            aboutuslabel.sizeToFit()
            return aboutuslabel.frame.height
        default:
            return 0
        }
    }
    
    func promotionsToPOI(){
        for promotion in promotions{
//            let latitude = promotion["latitude"] as! String
//            let longitude = promotion["longitude"] as! String
//            var img_link = promotion["imagename"] as! String
//            img_link = promotionBaseURL + img_link
//            let poi = PlaceOfInterest.init(latitude: latitude, andLongitude: longitude)
//            poi?.imageView.af_setImage(withURL: URL(string: img_link)!)
//            poi?.title = promotion["period"] as! String
//            self.places.append(poi!)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
        NSLog("MallDetailsViewController will appear")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
        NSLog("MallDetailsViewController will disappear")
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
}

extension MallDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return infos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell",
                                                      for: indexPath) as! InfoCollectionViewCell
        let key = infos.allKeys[indexPath.row] as! String
        let val = infos[key] as! String
        
        cell.infoKeyLabel.text = key
        cell.infoValLabel.text = val
        
        return cell
    }
}

