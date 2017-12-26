//
//  ServiceListViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/10/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
enum ServiceMode:UInt {
    case Parking = 0, FreeWifi, Lockers
}
public class ServiceListViewController: AdViewController, UITableViewDelegate, UITableViewDataSource {
    var list : [NSDictionary] = []
    var mode : ServiceMode = .Parking
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("MetroViewController awake from nib")
    }
    @IBOutlet weak var tableView: UITableView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        switch(mode) {
        case .Parking:
            self.title = NSLocalizedString("Parking", comment: "Parking")
            break
        case .FreeWifi:
            self.title = NSLocalizedString("Free WiFi", comment: "Free WiFi")
            break
        case .Lockers:
            self.title = NSLocalizedString("Daily Lockers", comment: "Daily Lockers")
            break
        }
        
        getList()
    }
    func getList(){
        switch mode {
        case .Parking:
            NetworkManger.sharedInstance.getParkingsAPI(parameters: [:], completionHandler: { (json, status) in
                print(json)
                self.list = json["parkings"] as! [NSDictionary]
                self.tableView.reloadData()
            })
            break
        case .FreeWifi:
            NetworkManger.sharedInstance.getFreeWifisAPI(parameters: [:], completionHandler: { (json, status) in
                print(json)
                self.list = json["free_wifis"] as! [NSDictionary]
                self.tableView.reloadData()
            })
            break
        case .Lockers:
            NetworkManger.sharedInstance.getDailyLockersAPI(parameters: [:], completionHandler: { (json, status) in
                print(json)
                self.list = json["dailylockers"] as! [NSDictionary]
                self.tableView.reloadData()
            })
            break
        }
    }
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Places List appear")
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceListCell") as! ServiceListCell
        let data = list[indexPath.row]
        switch mode {
        case .Parking:
            cell.iconView.image = UIImage(named: "parking")
            break
        case .FreeWifi:
            cell.iconView.image = UIImage(named: "free-wifi")
            break
        case .Lockers:
            cell.iconView.image = UIImage(named: "locker")
            break
        }
        cell.titleLabel.text = data["name"] as? String
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
class ServiceListCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var cellData : NSDictionary = [:]
    func configureCell(){
        
        titleLabel.text = cellData["name"] as? String
    }
    
}
