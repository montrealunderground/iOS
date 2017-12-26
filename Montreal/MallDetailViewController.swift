//
//  MallDetailViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class MallDetailViewController: UIViewController {
    var mall : NSDictionary = [:]
    var baseURL : String = ""
    var promotionBaseURL : String = ""
    var location : String = ""
    var promotions : [NSDictionary] = []
    var places : [PlaceOfInterest] = []
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("MallDetailViewController awake from nib")
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cinemaLabel: UILabel!
    @IBOutlet weak var storesLabel: UILabel!
    @IBOutlet weak var fastLabel: UILabel!
    @IBOutlet weak var museumLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtOpenHours: UITextView!
    @IBOutlet weak var txtAboutUs: UITextView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        title = mall["name"] as? String
        configureData()
//        NetworkManger.sharedInstance.getShoppingMallByIdAPI(parameters: ["id" : mall["id"] as! String]) { (json, status) in
//            print(json)
//        }
    }
    func configureData(){
        print(mall)
        print(self.baseURL)
        self.titleLabel.text = mall["name"] as? String
        var img_link = mall["coverphoto_filename"] as! String
        img_link = baseURL + img_link
        imgView.af_setImage(withURL: URL(string: img_link)!)
        txtOpenHours.text = mall["workinghours"] as? String
        txtAboutUs.text = mall["aboutus"] as? String
        location = (mall["contact"] as? String)!
        let info = mall["info"] as! String
        do{
            let infoDict = try JSONSerialization.jsonObject(with: info.data(using: .utf8)!, options: []) as! [NSDictionary]
            self.fastLabel.text = infoDict["Fast food"] as? String
            self.cinemaLabel.text = infoDict["Museum"] as? String
            self.storesLabel.text = infoDict["Stores"] as? String
        }catch{
            print("Error Parsing JSON from register_user_v2")
        }
        promotions = mall["promotions"] as! [NSDictionary]
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: 1220)
        promotionsToPOI()
    }
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func storeAction(_ sender: Any) {
        appDelegate.placesVC.mode = .Restaurants
        configureBackButton()
        self.navigationController?.pushViewController(appDelegate.placesVC, animated: true)
    }
    @IBAction func mapAction(_ sender: Any) {
        configureBackButton()
        self.navigationController?.pushViewController(appDelegate.undergroundVC, animated: true)
    }
    @IBAction func locationAction(_ sender: Any) {
        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "locationViewController") as! LocationViewController
        locationVC.location = self.location
        configureBackButton()
        self.navigationController?.pushViewController(locationVC, animated: true)
    }
    @IBAction func arAction(_ sender: Any) {
        let arVC = self.storyboard?.instantiateViewController(withIdentifier: "arViewController") as! AugmentedViewController
        arVC.places = self.places
        configureBackButton()
        self.navigationController?.pushViewController(arVC, animated: true)
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    func promotionsToPOI(){
        for promotion in promotions{
            let latitude = promotion["latitude"] as! String
            let longitude = promotion["longitude"] as! String
            var img_link = promotion["imagename"] as! String
            img_link = promotionBaseURL + img_link
            let poi = PlaceOfInterest.init(latitude: latitude, andLongitude: longitude)
            poi?.imageView.af_setImage(withURL: URL(string: img_link)!)
            poi?.title = promotion["period"] as! String
            self.places.append(poi!)
        }
    }
    
}
