//
//  JobsViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class JobsViewController: AdViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("JobsViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Services & Jobs", comment:"Services & Jobs")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("JobsViewController will appear")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("JobsViewController will disappear")
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobListCell") as! JobListCell
        cell.accessoryType = .disclosureIndicator
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = NSLocalizedString("Jobs", comment:"Jobs")
            cell.iconView.image = UIImage(named: "jobs")
            break
        case 1:
            cell.titleLabel.text = NSLocalizedString("Parking", comment:"Parking")
            cell.iconView.image = UIImage(named: "parking")
            break
        case 2:
            cell.titleLabel.text = NSLocalizedString("Free WiFi", comment:"Free WiFi")
            cell.iconView.image = UIImage(named: "free-wifi")
            break
        case 3:
            cell.titleLabel.text = NSLocalizedString("Daily Lockers", comment:"Daily Lockers")
            cell.iconView.image = UIImage(named: "locker")
            break
        default:
            break
        }
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let jobListVC = self.storyboard?.instantiateViewController(withIdentifier: "jobListViewController") as! JobListViewController
            configureBackButton()
            self.navigationController?.pushViewController(jobListVC, animated: true)
            break
        case 1:
            let serviceListVC = self.storyboard?.instantiateViewController(withIdentifier: "serviceListViewController") as! ServiceListViewController
            serviceListVC.mode = .Parking
            configureBackButton()
            self.navigationController?.pushViewController(serviceListVC, animated: true)
            break
        case 2:
            let serviceListVC = self.storyboard?.instantiateViewController(withIdentifier: "serviceListViewController") as! ServiceListViewController
            serviceListVC.mode = .FreeWifi
            configureBackButton()
            self.navigationController?.pushViewController(serviceListVC, animated: true)
            break
        case 3:
            let serviceListVC = self.storyboard?.instantiateViewController(withIdentifier: "serviceListViewController") as! ServiceListViewController
            serviceListVC.mode = .Lockers
            configureBackButton()
            self.navigationController?.pushViewController(serviceListVC, animated: true)
            break
        default:
            break
        }
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
}
class JobListCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var cellData : NSDictionary = [:]
    func configureCell(){
        
    }
    
}
