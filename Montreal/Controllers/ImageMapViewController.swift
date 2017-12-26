//
//  ImageMapViewController.swift
//  Montreal
//
//  Created by Eagle on 11/9/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//


import UIKit

public class ImageMapViewController: AdViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ivImage: UIImageView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.ivImage.frame.height)
//        ivImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
//        ivImage.af_setImage(withURL: URL(string: "http://i1.wp.com/montrealsouterrain.ca/wp-content/uploads/2015/11/Nouvelle-Carte-Montreal-Souterrain-Edition-printemps-2016-mai.png")!)
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
}
