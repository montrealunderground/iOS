//
//  ARListViewController.swift
//  Montreal
//
//  Created by William Andersson on 3/17/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class ARListViewController : AdViewController, UITableViewDelegate, UITableViewDataSource, pARkViewControllerDelegate, MapPlaceListViewControllerDelegate {

    var promotions : [NSDictionary] = []
    var baseURL : String = ""
    let types = ["All", "Restaurant", "Boutique", "Beauty & Health", "Attraction"]
    let typeimgs = ["jobs", "resto-listicon", "boutique-listicon", "salon-iconlist", "attraction-iconlist"]
    
    @IBOutlet weak var tableView: UITableView!
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("ARListViewController awake from nib")
        NetworkManger.sharedInstance.getPromotionsAPI(parameters: [:]) { (json, status) in
            let result = json["result"] as! String
            print(json)
            if result == "success"{
                self.promotions = json["promotions"] as! [NSDictionary]
                self.baseURL = json["download_prefix_promotion"] as! String
            }
        }
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("AR View", comment:"AR View")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("ARListViewController will appear")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("ARListViewController will disappear")
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ARCategoryListCell") as! ARCategoryListCell
        cell.titleLabel.text = NSLocalizedString(self.types[indexPath.row], comment:self.types[indexPath.row])
        cell.iconView.image = UIImage(named: typeimgs[indexPath.row])
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arViewController = self.storyboard?.instantiateViewController(withIdentifier: "pARkViewController") as! pARkViewController
        arViewController.baseimageurl = self.baseURL
        arViewController.delegate = self
        
        let selectedPromos:NSMutableArray = []
        let selectedType:String = NSLocalizedString(self.types[indexPath.row], comment:self.types[indexPath.row])
        arViewController.type = selectedType
        if (indexPath.row >= 1 && indexPath.row <= 4) {
            for promotion in self.promotions{
                let storetype = promotion["storetype"] as! String
                if (storetype == selectedType) {
                    selectedPromos.add(promotion)
                }
            }
            arViewController.promotions = selectedPromos as! [Any]
        } else {
            arViewController.promotions = self.promotions
        }
        
        arViewController.title? = NSLocalizedString("AR View", comment:"AR View")
        self.navigationController?.pushViewController(arViewController, animated: true)
    }
    func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    public func onGotoStore(_ storename:String!, link: String!) {
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "rentFormViewController") as! RentFormViewController
        webVC.titlename = storename
        webVC.url = link
        configureBackButton()
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
    
class ARCategoryListCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var cellData : NSDictionary = [:]
    func configureCell(){
    }
}
