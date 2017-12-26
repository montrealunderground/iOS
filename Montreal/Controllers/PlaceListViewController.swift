//
//  PlaceListViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation

public class PlaceListViewController: AdViewController, UITableViewDelegate, UITableViewDataSource {
    var list : [NSDictionary] = []
    var baseURL: String!
    var coverphotoURL: String!
    var mode : PlacesMode = .Restaurants
    var setSpacing : Bool! = false
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("PlaceListViewController awake from nib")
    }
    @IBOutlet weak var tableView: UITableView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        var newWidth:CGFloat, newHeight:CGFloat, spacing:CGFloat
        let adsHeight:CGFloat = 50.0
        if (self.parent == nil) {
            newWidth = UIScreen.main.bounds.width
            newHeight = UIScreen.main.bounds.height
        } else {
            newWidth = (self.parent?.view.frame.width)!
            newHeight = (self.parent?.view.frame.height)!
        }
        if (setSpacing == true) {
            spacing = 110.0
        } else {
            spacing = 0.0
        }
        tableView.frame = CGRect(x: 0, y: spacing, width: newWidth, height: newHeight - spacing - adsHeight)
        //self.edgesForExtendedLayout = UIRectEdge.all
        //self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    }
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        print("Places List appear")
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceListCell") as! PlaceListCell
        cell.cellData = list[indexPath.row]
        cell.baseimageurl = self.baseURL
        cell.mode = mode
        cell.configureCell()
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = list[indexPath.row] as! NSDictionary
        let featured = place["featured"] as! String
        if (featured == "0") {
            let placeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "placeDetailViewController") as! PlaceDetailViewController
            placeDetailVC.place = list[indexPath.row]
            placeDetailVC.baseimageurl = self.baseURL
            configureBackButton()
            self.navigationController?.pushViewController(placeDetailVC, animated: true)
        } else {
            let placeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "featuredPlaceViewController") as! FeaturedPlaceViewController
            placeDetailVC.store = list[indexPath.row]
            placeDetailVC.coverphotobaseURL = self.coverphotoURL
            configureBackButton()
            self.navigationController?.pushViewController(placeDetailVC, animated: true)
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
}
class PlaceListCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var mode : PlacesMode = .Restaurants
    var baseimageurl:String!
    var cellData : NSDictionary = [:]

    func configureCell(){
        let imagename = cellData["imagename"] as? String
        
        if ( imagename?.characters.count == 0 ) {
            let type = cellData["type"] as! String
            if type == NSLocalizedString("Beauty & Health", comment:"Beauty & health") {
                iconView.image = UIImage(named: "salon-iconlist")
            }else if type == NSLocalizedString("Boutique", comment:"Boutique") {
                iconView.image = UIImage(named: "boutique-listicon")
            }else if type == NSLocalizedString("Attraction", comment:"Attraction") {
                iconView.image = UIImage(named: "attraction-iconlist")
            }else if type == NSLocalizedString("Restaurant", comment:"Restaurant") {
                iconView.image = UIImage(named: "resto-listicon")
            }
        } else {
            iconView.af_setImage(withURL: URL(string: (self.baseimageurl + imagename!) as String!)!)
        }
        titleLabel.text = cellData["name"] as? String
        categoryLabel.text = cellData["type"] as? String
    }
}
