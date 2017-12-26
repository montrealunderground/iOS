//
//  RentFormViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
import GoogleMobileAds

public class RentFormViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var interstitial: GADInterstitial!
    
    var url : String = ""
    var titlename:String = ""
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("RentFormViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = titlename
        createAndLoadInterstitial()
        webView.loadRequest(URLRequest(url: URL(string: url)!))
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        NSLog("RentFormViewController will appear")
    }
    public override func viewDidAppear(_ animated: Bool) {
        
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //createAndLoadInterstitial()
        NSLog("RentFormViewController will disappear")
    }
    
    fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: NSLocalizedString(Constants.INTERSTITIAL_ADS_UNIT_ID, comment: ""))
        let request = GADRequest()
        interstitial.load(request)
    }
}
