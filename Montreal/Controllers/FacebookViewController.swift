//
//  FacebookViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
import GoogleMobileAds

public class FacebookViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var interstitial: GADInterstitial!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        print("FacebookViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        if ((appDelegate.interstitialAdsState.object(forKey: "FacebookViewController") as! String) == "1") {
            createAndLoadInterstitial()
        }
        webView.loadRequest(URLRequest(url: URL(string: "https://www.facebook.com/MontrealSouterrain/")!))
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NSLog("FacebookViewController will appear")
    }
    public override func viewDidAppear(_ animated: Bool) {
        if ((appDelegate.interstitialAdsState.object(forKey: "FacebookViewController") as! String) == "1") {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        } else {
            print("Not showing interstitial Ads")
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NSLog("FacebookViewController will disappear")
    }
    
    fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: NSLocalizedString(Constants.INTERSTITIAL_ADS_UNIT_ID, comment: ""))
        let request = GADRequest()
        interstitial.load(request)
    }
}
