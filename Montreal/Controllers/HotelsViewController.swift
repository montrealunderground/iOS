//
//  HotelsViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class HotelsViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("HotelsViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hotels"
        webView.loadRequest(URLRequest(url: URL(string: "https://www.hotelscombined.com/Place/Montreals_Underground_City.htm")!))
    }
    
    func pushViewController(_ sender: AnyObject) {
        let viewController = UIViewController.init()
        viewController.title = "Pushed Controller"
        viewController.view.backgroundColor = UIColor.white
        configureBackButton()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("HotelsViewController will appear")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("HotelsViewController will disappear")
    }
}
