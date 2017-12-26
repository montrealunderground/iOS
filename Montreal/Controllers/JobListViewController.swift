//
//  JobListViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/10/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class JobListViewController: AdViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var jobs : [NSDictionary] = []
    @IBOutlet weak var collectionView: UICollectionView!
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("LocationViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Jobs", comment: "Jobs")
        NetworkManger.sharedInstance.getJobsAPI(parameters: [:]) { (json, status) in
            print(json)
            self.jobs = json["jobs"] as! [NSDictionary]
            self.collectionView.reloadData()
        }
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobs.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobCell", for: indexPath) as! JobsCollectionViewCell
        let data = jobs[indexPath.row] as NSDictionary
        print(data)
        cell.cellData = data
        cell.configureCell()
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = jobs[indexPath.row] as NSDictionary
        let rentFormVC = self.storyboard?.instantiateViewController(withIdentifier: "rentFormViewController") as! RentFormViewController
        rentFormVC.title = data["title"] as! String
        rentFormVC.url = data["link"] as! String
        configureBackButton()
        self.navigationController?.pushViewController(rentFormVC, animated: true)
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
}
class JobsCollectionViewCell: UICollectionViewCell {
    var cellData : NSDictionary = [:]
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    func configureCell(){
        companyLabel.text = cellData["company"] as? String
        titleLabel.text = cellData["title"] as? String
        typeLabel.text = cellData["type"] as? String
        descriptionLabel.text = cellData["description"] as? String
    }
}
