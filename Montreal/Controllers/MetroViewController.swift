//
//  MetroViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/10/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class MetroViewController: AdViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list : [NSDictionary] = []
    var mode : PlacesMode = .Restaurants
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("MetroViewController awake from nib")
    }
    @IBOutlet var tableView: UITableView!
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Places List appear")
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetroListCell") as! MetroListCell
        let metro = list[indexPath.row] as! NSDictionary
        cell.titleLabel.text = metro["name"] as! String!
        cell.iconView.image = UIImage(named: "metro-green")
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let metro = list[indexPath.row] as! NSDictionary
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
            parameter = ["metroid":(metro["id"] as! String!)]
        } else {
            parameter = ["type":type,"metroid":(metro["id"] as! String!)]
        }
        NetworkManger.sharedInstance.getStoresAPI(parameters: parameter as! [String : String]) { (json, status) in
            let allPlaceViewController = self.storyboard?.instantiateViewController(withIdentifier: "placeListViewController") as! PlaceListViewController
            print(json)
            let list1 = json["stores"] as! [NSDictionary]
            allPlaceViewController.list = list1
            allPlaceViewController.title = metro["name"] as! String
            allPlaceViewController.mode = self.mode
            allPlaceViewController.baseURL = json["download_prefix_store"] as! String
            allPlaceViewController.coverphotoURL = json["download_prefix_store_coverphoto"] as! String
            self.configureBackButton()
            self.navigationController?.pushViewController(allPlaceViewController, animated: true)
        }
//        let placeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "placeDetailViewController") as! PlaceDetailViewController
//        placeDetailVC.place = list[indexPath.row]
//        self.navigationController?.pushViewController(placeDetailVC, animated: true)
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

}
class MetroListCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var cellData : NSDictionary = [:]
    func configureCell(){
        
        titleLabel.text = cellData["name"] as? String
    }
    
}
