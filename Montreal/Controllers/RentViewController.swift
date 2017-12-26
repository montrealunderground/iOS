//
//  RentViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class RentViewController: AdViewController {
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("RentViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
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
        NSLog("RentViewController will appear")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("RentViewController will disappear")
    }
    @IBAction func rentAction(_ sender: Any) {
        let rentFormVC = self.storyboard?.instantiateViewController(withIdentifier: "rentFormViewController") as! RentFormViewController
        rentFormVC.url = "http://vortexapp.ca/contactbuilder/editor/forms/3/index.php"
        configureBackButton()
        self.navigationController?.pushViewController(rentFormVC, animated: true)
    }
    
}
