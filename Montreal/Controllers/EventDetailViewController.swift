//
//  EventDetailViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/9/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
import GoogleMobileAds

public class EventDetailViewController: AdViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var linkurl : String!
    var interstitial: GADInterstitial!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        print("EventDetailViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        createAndLoadInterstitial()
        webView.loadRequest(URLRequest(url: URL(string: linkurl)!))
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NSLog("RentFormViewController will appear")
    }
    public override func viewDidAppear(_ animated: Bool) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: NSLocalizedString(Constants.INTERSTITIAL_ADS_UNIT_ID, comment: ""))
        let request = GADRequest()
        interstitial.load(request)
    }
}

