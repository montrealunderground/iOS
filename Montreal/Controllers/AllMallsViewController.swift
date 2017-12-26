//
//  AllMallsViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class AllMallsViewController: AdViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var malls : [Any] = []
    var mode : PlacesMode = .Restaurants
    var imgBaseURL : String = ""
    var imgCoverBaseURL : String = ""
    var imgPromotionBaseURL : String = ""
    @IBOutlet var collectionView: UICollectionView!
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("AllMallsViewController awake from nib")
//        collectionView.register(AllMallsCollectionViewCell.self, forCellWithReuseIdentifier: "MallCell")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        NetworkManger.sharedInstance.getShoppingMallsAPI(parameters: [:]) { (json, status) in
            let result = json["result"] as! String
            print(json)
            if result == "success"{
                self.imgBaseURL = json["download_prefix_logo"] as! String
                self.imgCoverBaseURL = json["download_prefix_coverphoto"] as! String
                self.imgPromotionBaseURL = json["download_prefix_promotion"] as! String
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MallCell", for: indexPath) as! AllMallsCollectionViewCell
        let mall = self.malls[indexPath.row] as! NSDictionary
        var logo_filename : String = mall["logophoto_filename"] as! String
        logo_filename = self.imgBaseURL+logo_filename
        cell.imgView.af_setImage(withURL: URL(string: logo_filename)!)
        cell.isHeightCalculated = true
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mall = self.malls[indexPath.row] as! NSDictionary
        let mallDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "mallDetailsViewController") as! MallDetailsViewController
        self.configureBackButton()
        mallDetailVC.mall = mall
        var logo_filename : String = mall["logophoto_filename"] as! String
        logo_filename = self.imgBaseURL+logo_filename
        mallDetailVC.baseURL = self.imgCoverBaseURL
        mallDetailVC.promotionBaseURL = self.imgPromotionBaseURL
        self.navigationController?.pushViewController(mallDetailVC, animated: true)
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
}
class AllMallsCollectionViewCell: UICollectionViewCell {
    
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
