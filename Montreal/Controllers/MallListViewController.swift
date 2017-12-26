//
//  MallListViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class MallListViewController: AdViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var malls : [Any] = []
    var mode : PlacesMode = .Restaurants
    var imgBaseURL : String = ""
    var imgCoverBaseURL : String = ""
    @IBOutlet var collectionView: UICollectionView!
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("MallListViewController awake from nib")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        NetworkManger.sharedInstance.getShoppingMallsAPI(parameters: [:]) { (json, status) in
            let result = json["result"] as! String
            print(json)
            if result == "success"{
                self.imgBaseURL = json["download_prefix_logo"] as! String
                self.imgCoverBaseURL = json["download_prefix_coverphoto"] as! String
                self.malls = json["shopping_malls"] as! [Any]
                self.collectionView.reloadData()
            }
            self.collectionFlowLayout.estimatedItemSize = CGSize(width: 300, height: 80)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.malls.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MallCell", for: indexPath) as! MallListCollectionViewCell
        let mall = self.malls[indexPath.row] as! NSDictionary
        var logo_filename : String = mall["logophoto_filename"] as! String
        logo_filename = self.imgBaseURL+logo_filename
        cell.imgView.af_setImage(withURL: URL(string: logo_filename)!)
        cell.isHeightCalculated = true
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mall = self.malls[indexPath.row] as! NSDictionary
        var type : String = "restaurant"
        switch mode {
        case .Restaurants:
            type = NSLocalizedString("Restaurant", comment: "restaurant")
            break
        case .Boutiques:
            type = NSLocalizedString("Boutique", comment: "boutique")
            break
        case .Attractions:
            type = NSLocalizedString("Attraction", comment: "attraction")
            break
        case .BeautyHealth:
            type = NSLocalizedString("Beauty & Health", comment:"beauty & health")
            break
        case .Stores:
            break
        default:
            break
        }
        var parameter : NSDictionary = [:]
        if (mode == .Stores) {
            parameter = ["mallid":(mall["id"] as! String!)]
        } else {
            parameter = ["type":type,"mallid":(mall["id"] as! String!)]
        }
        NetworkManger.sharedInstance.getStoresAPI(parameters: parameter as! [String : String]) { (json, status) in
            let allPlaceViewController = self.storyboard?.instantiateViewController(withIdentifier: "placeListViewController") as! PlaceListViewController
            print(json)
            let list1 = json["stores"] as! [NSDictionary]
            allPlaceViewController.list = list1
            allPlaceViewController.title = mall["name"] as! String
            allPlaceViewController.mode = self.mode
            allPlaceViewController.baseURL = json["download_prefix_store"] as! String
            allPlaceViewController.coverphotoURL = json["download_prefix_store_coverphoto"] as! String
            self.configureBackButton()
            self.navigationController?.pushViewController(allPlaceViewController, animated: true)
        }
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
}
class MallListCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    @IBOutlet weak var imgView: UIImageView!
    var isHeightCalculated: Bool = false
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
