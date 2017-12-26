//
//  ProfileViewController.swift
//  Montreal
//
//  Created by William Andersson on 4/22/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//
import GoogleMobileAds
import Foundation

public class ProfileViewController: UIViewController, GADRewardBasedVideoAdDelegate {
    var rewardBasedVideo: GADRewardBasedVideoAd!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var profileBalanceTextView: UILabel!
    @IBOutlet weak var profileNameTextView: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBAction func onGetFreeAction(_ sender: Any) {
        if rewardBasedVideo.isReady == true {
            rewardBasedVideo.present(fromRootViewController: self)
        }
    }
    
    @IBAction func onPurchaseItem(_ sender: Any) {
        let ucstoreVC = self.storyboard?.instantiateViewController(withIdentifier: "ucitemStoreViewController") as! UCStoreViewController
        ucstoreVC.title = NSLocalizedString("UnderCoins Store", comment:"ucstore")
        configureBackButton()
        self.navigationController?.pushViewController(ucstoreVC, animated: true)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedVideo.delegate = self
        
        rewardBasedVideo.load(GADRequest(), withAdUnitID: NSLocalizedString(Constants.AWARDED_VIDEO_ADS_UNIT_ID, comment:"VideoAdUnitId") )
        
        
        print(Constants.profileImgUrl)
        profileImgView.af_setImage(withURL: URL(string:Constants.profileImgUrl)!)
        profileNameTextView.text = Constants.profileName
        self.updateBalance()
        
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateBalance()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
    }
    
    public func updateBalance() {
        if (profileBalanceTextView != nil) {
            profileBalanceTextView.text = NSLocalizedString("Balance", comment:"balance") + ": " + Constants.profileBalance + " UC"
        }
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
        rewardBasedVideo.load(GADRequest(), withAdUnitID: NSLocalizedString(Constants.AWARDED_VIDEO_ADS_UNIT_ID, comment:"VideoAdUnitId") )
        
        print("Reward based video ad is closed.")
    }
    
    public func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    public func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency")
        
        NetworkManger.sharedInstance.awardVideo(userid: Constants.profileUserId) { (json, status) in
            let result = json["result"] as! String
            print(json)
            if result == "success"{
                Constants.profileBalance = json["undercoin"] as! String
                self.updateBalance()
                self.showAwardedVideo()
                //self.profileBalanceTextView.text = NSLocalizedString("Balance", comment:"balance") + ":" + Constants.profileBalance + " UC"
            }
        }
    }
    
    public func showAwardedVideo() {
        let alert = UIAlertController(title: NSLocalizedString("You have been rewarded", comment:"rewardedtitle"), message: NSLocalizedString("You got 10 coins", comment:"rewardedmessage"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:"ok"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
//        alert.present(self, animated: true, completion: nil)
    }
}
