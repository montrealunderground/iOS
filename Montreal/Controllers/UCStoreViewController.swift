//
//  UCItemStoreViewController.swift
//  Montreal
//
//  Created by William Andersson on 4/22/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//
import GoogleMobileAds
import Foundation

public class UCStoreViewController: AdViewController, UICollectionViewDelegate, UICollectionViewDataSource, GADRewardBasedVideoAdDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var ucitems : [NSDictionary] = []
    var baseURL : String = ""
    
    @IBOutlet weak var balanceTextView: UILabel!
    var currentIndex : Int = -1
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: NSLocalizedString(Constants.AWARDED_VIDEO_ADS_UNIT_ID, comment:"VideoAdUnitId") )
        GADRewardBasedVideoAd.sharedInstance().delegate = self
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        
//        rewardBasedVideo?.load(GADRequest(), withAdUnitID:"ca-app-pub-3940256099942544/1712485313" )
        self.balanceTextView.text = NSLocalizedString("Balance", comment:"balance") + ":" + Constants.profileBalance + " UC"
        
        currentIndex = -1
        NetworkManger.sharedInstance.getUCItemsAPI(parameters: [:]) { (json, status) in
            print(json)
            self.baseURL = json["download_prefix_undercoinstore"] as! String
            self.ucitems = json["ucitems"] as! [NSMutableDictionary]
            self.collectionView.reloadData()
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("UCStoreViewController will appear")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("UCStoreViewController will disappear")
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ucitems.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UCItemCell", for: indexPath) as! UCItemCollectionViewCell
        let data = ucitems[indexPath.row]
        cell.index = indexPath.row
        cell.cellData = NSMutableDictionary(dictionary: data)
        cell.collectionViewController = self
        var image_link = data["imagename"] as! String
        image_link = baseURL + image_link
        cell.baseURL = self.baseURL
        cell.imageView.af_setImage(withURL: URL(string: image_link)!)
        cell.configureCell()
        return cell
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        guard let popupViewController = segue.destination as? PopupViewController else { return }
        
        let data = ucitems[currentIndex] as NSDictionary
        var image_link = data["imagename"] as! String
        image_link = baseURL + image_link
        popupViewController.imageurl = image_link
        popupViewController.titlecontent = data["name"] as! String
        
        popupViewController.customBlurEffectStyle = .light
        popupViewController.customAnimationDuration = 0.5
        popupViewController.customInitialScaleAmmount = 0.7
    }
    
    // MARK: GADRewardBasedVideoAdDelegate implementation
    
    public func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                                   didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load: \(error.localizedDescription)")
    }
    
    public func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    public func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    public func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    public func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: NSLocalizedString(Constants.AWARDED_VIDEO_ADS_UNIT_ID, comment:"VideoAdUnitId") )
        print("Reward based video ad is closed.")
    }
    
    public func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    public func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                                   didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency")
        //ApiHelper.awardVideo(mContext, userid, new RequestCallback<JSONObject>() {
        NetworkManger.sharedInstance.awardVideo(userid: Constants.profileUserId) { (json, status) in
            let result = json["result"] as! String
            print(json)
            if result == "success"{
                Constants.profileBalance = json["undercoin"] as! String
                self.balanceTextView.text = NSLocalizedString("Balance", comment:"balance") + ":" + Constants.profileBalance + " UC"
                
                let alert = UIAlertController(title: NSLocalizedString("You have been rewarded", comment:"rewardedtitle"), message: NSLocalizedString("You got 10 coins", comment:"rewardedmessage"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:"ok"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        //                Constants.profileBalance = response.getString("undercoin");
    }
}
class UCItemCollectionViewCell: UICollectionViewCell {
    var baseURL: String!
    var index: Int = -1
    
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var freeucBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var cellData : NSMutableDictionary = [:]
    var collectionViewController : UCStoreViewController!
    func configureCell(){
        titleLabel.text = cellData["name"] as? String
        titleLabel.textColor = UIColor.black // (red: 203, green: 67, blue: 53, alpha: 1)
        //titleLabel.layer.backgroundColor = UIColor(red: 42, green: 134, blue: 53, alpha: 0.6).cgColor
        
        priceLabel.text = cellData["price"] as! String + " UC"
        priceLabel.textColor = UIColor.black // (red: 203, green: 67, blue: 53, alpha: 1)
        //priceLabel.layer.backgroundColor = UIColor(red: 253, green: 214, blue: 0, alpha: 0.6).cgColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        collectionViewController.currentIndex = index
        collectionViewController.performSegue(withIdentifier: "ucitemPopup", sender: self)
    }
    @IBAction func onFreeUCAction(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: collectionViewController)
        }
    }
    
    @IBAction func onRedeemAction(_ sender: Any) {
        let price = Int(cellData["price"] as! String)
        let balance = Int(Constants.profileBalance)
        if ( balance! < price! ) {
            let alert = UIAlertController(title: NSLocalizedString("You don't have enough coins to redeem this item.", comment:"tt"), message: NSLocalizedString("Do you really want to get more coins by watching the video?", comment:"message"), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default) { action in
                if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                    GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self.collectionViewController)
                }
            })
            alert.addAction(UIAlertAction(title: "No", style: .cancel)  { action in
            })
            collectionViewController.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: NSLocalizedString("Redeem Under Coin Item", comment:"redeem"), message: NSLocalizedString("Do you really want to buy this item?", comment:"buy"), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default) { action in
                let redeemVC = self.collectionViewController.storyboard?.instantiateViewController(withIdentifier: "redeemViewController") as! RedeemViewController
                redeemVC.productData = self.cellData as NSMutableDictionary
                redeemVC.productData["imagename"] = self.collectionViewController.baseURL+(self.cellData["imagename"] as! String)
                self.collectionViewController.configureBackButton()
                self.collectionViewController.navigationController?.pushViewController(redeemVC, animated: true)
            })
            alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment:"no"), style: .cancel)  { action in
            })
            collectionViewController.present(alert, animated: true, completion: nil)
        }
    }
}
