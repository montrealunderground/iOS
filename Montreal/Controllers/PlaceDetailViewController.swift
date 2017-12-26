//
//  PlaceDetailViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
@objc public class PlaceDetailViewController: AdViewController {
    var place : NSDictionary = [:]
    var baseimageurl : String!
    var isFromSearch : Bool = false
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("PlaceDetailViewController awake from nib")
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mallLabel: UILabel!
    @IBOutlet weak var metroLabel: UILabel!
    override public func viewDidLoad() {
        super.viewDidLoad()
        print(place)
        self.title = place["name"] as? String
        
        let imagename = place["imagename"] as? String
        
        if ( imagename == nil || imagename?.characters.count == 0 ) {
            let type = place["type"] as! String
            if type == NSLocalizedString("Beauty & Health", comment:"Beauty & health") {
                self.imageView.image = UIImage(named: "salon-iconlist")
            }else if type == NSLocalizedString("Boutique", comment:"Boutique") {
                self.imageView.image = UIImage(named: "boutique-listicon")
            }else if type == NSLocalizedString("Attraction", comment:"Attraction") {
                self.imageView.image = UIImage(named: "attraction-iconlist")
            }else if type == NSLocalizedString("Restaurant", comment:"Restaurant") {
                self.imageView.image = UIImage(named: "resto-listicon")
            }
        } else {
            self.imageView.af_setImage(withURL: URL(string: (self.baseimageurl + imagename!) as String!)!)
        }
        
        titleLabel.text = place["name"] as? String
        typeLabel.text = "Type : " + (place["type"] as? String)!
        metroLabel.text = "Metro : " + (place["metroname"] as? String)!
        mallLabel.text = "Mall : " + (place["mallname"] as? String)!
    }
    
    @IBAction func contactAction(_ sender: Any) {
        print(place["contact"] ?? "")
        let contact = place["contact"] as! String
        guard let number = URL(string: "telprompt://" + contact) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    @IBAction func facebookAction(_ sender: Any) {
        print(place["facebook"] ?? "")
        let facebook = place["facebook"] as! String
        let rentFormVC = self.storyboard?.instantiateViewController(withIdentifier: "rentFormViewController") as! RentFormViewController
        rentFormVC.titlename = (place["name"] as? String)!
        rentFormVC.url = facebook
        configureBackButton()
        self.navigationController?.pushViewController(rentFormVC, animated: true)
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    @IBAction func onFacebookShare(_ sender: Any) {
        self.showfbShareDialog(content: (place["name"] as? String)!, isURL: false)
    }
    @IBAction func onTwitterShare(_ sender: Any) {
        self.showtwShareDialog(content: (place["name"] as? String)!, isURL: false)
    }
    @IBAction func onGpShare(_ sender: Any) {
        self.showgpShareDialog(content: (place["name"] as? String)!, isURL: false)
    }
}
