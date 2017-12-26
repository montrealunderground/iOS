//
//  PromotionViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation

import GoogleMobileAds
import AudioToolbox

public class PromotionViewController: UICollectionViewController, GADBannerViewDelegate {
    var adMobBannerView = GADBannerView()
    var offers : [NSDictionary] = []
    var baseURL : String = ""
    
    var currentIndex : Int = -1
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Init AdMob banner
        initAdMobBanner()
        self.collectionView?.frame = CGRect(x:0, y:0, width:(self.collectionView?.frame.size.width)!, height:(self.collectionView?.frame.size.height)!-50)
        NetworkManger.sharedInstance.getPromotionsAPI(parameters: [:]) { (json, status) in
            print(json)
            self.baseURL = json["download_prefix_promotion"] as! String
            self.offers = json["promotions"] as! [NSDictionary]
            self.collectionView?.reloadData()
        }
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionCell", for: indexPath) as! PromotionCollectionViewCell
        let offer = self.offers[indexPath.row] 
        var img_link = offer["imagename"] as! String
        img_link = baseURL + img_link
        cell.imgView.af_setImage(withURL: URL(string: img_link)!)
        cell.index = indexPath.row
        cell.cellData = offer
        cell.baseURL = self.baseURL
        cell.promotionViewController = self
        cell.configureCell()
        return cell
    }
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        guard let popupViewController = segue.destination as? PopupViewController else { return }
        
        let data = self.offers[currentIndex] as NSDictionary
        var image_link = data["imagename"] as! String
        image_link = baseURL + image_link
        popupViewController.imageurl = image_link
        popupViewController.titlecontent = data["storename"] as! String
        
        popupViewController.customBlurEffectStyle = .light
        popupViewController.customAnimationDuration = 0.5
        popupViewController.customInitialScaleAmmount = 0.7
    }
    
    // MARK: -  ADMOB BANNER
    func initAdMobBanner() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320 , height: 50))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
        } else  {
            // iPad
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 468, height: 60)
        }
        
        adMobBannerView.adUnitID = NSLocalizedString(Constants.BANNER_ADS_UNIT_ID, comment: "")
        adMobBannerView.rootViewController = self
        adMobBannerView.delegate = self
        view.addSubview(adMobBannerView)
        
        let request = GADRequest()
        adMobBannerView.load(request)
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
        UIView.beginAnimations("showBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = false
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView!) {
        showBanner(adMobBannerView)
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        hideBanner(adMobBannerView)
    }
}
class PromotionCollectionViewCell: UICollectionViewCell {
    var cellData: NSDictionary = [:]
    var baseURL: String!
    var index: Int = -1
    var promotionViewController: PromotionViewController!
    
    @IBOutlet weak var imgView: UIImageView!
    func configureCell(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
    }
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        promotionViewController.currentIndex = index
        promotionViewController.performSegue(withIdentifier: "promoPopup", sender: self)
    }
    @IBAction func offerAction(_ sender: Any) {
        let message = String(format: "%@\n%@\n%@", cellData["amount"] as! String, cellData["period"] as! String, cellData["description"] as! String)
        let alert = UIAlertController(title: NSLocalizedString("Offer Detail", comment:"Offer Detail"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment:"Fermer"), style: UIAlertActionStyle.default, handler: nil))
        promotionViewController.present(alert, animated: true, completion: nil)
    }
}
