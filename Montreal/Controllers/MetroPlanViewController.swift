//
//  SecondViewController.swift
//  AKSideMenuSimple
//
//  Created by Diogo Autilio on 6/7/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import UIKit

public class MetroPlanViewController: AdViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ivImage: UIImageView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.ivImage.frame.height)
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

    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("SecondViewController appeared")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("SecondViewController will disappear")
    }
}
