//
//  SearchResultViewController.swift
//  Montreal
//
//  Created by William Andersson on 3/23/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
import GoogleMobileAds

public class SearchResultViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var interstitial: GADInterstitial!
    
    var url : String = ""
    var storename: String = ""
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("SearchResultViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = storename
        webView.loadRequest(URLRequest(url: URL(string: url)!))
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //createAndLoadInterstitial()
        
        NSLog("SearchResultViewController will appear")
    }
    public override func viewDidAppear(_ animated: Bool) {
        /*if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }*/
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        appDelegate.window?.addSubview(appDelegate.searchVC.view)
        NSLog("SearchResultViewController will disappear")
    }
    
    fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: NSLocalizedString(Constants.INTERSTITIAL_ADS_UNIT_ID, comment: ""))
        let request = GADRequest()
        interstitial.load(request)
    }
}
