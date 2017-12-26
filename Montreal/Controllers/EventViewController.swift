//
//  EventViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
public class EventViewController: AdViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var events : [NSDictionary] = []
    var baseURL : String = ""
    
    var currentIndex : Int = -1
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("EventViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = -1
        NetworkManger.sharedInstance.getEventsAPI(parameters: [:]) { (json, status) in
            print(json)
            self.baseURL = json["download_prefix_event"] as! String
            self.events = json["events"] as! [NSDictionary]
            self.collectionView.reloadData()
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("EventViewController will appear")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("EventViewController will disappear")
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCollectionViewCell
        let data = events[indexPath.row] as NSDictionary
        cell.index = indexPath.row
        cell.cellData = data
        cell.collectionViewController = self
        var image_link = data["imagename"] as! String
        image_link = baseURL + image_link
        cell.baseURL = self.baseURL
        cell.imageView.af_setImage(withURL: URL(string: image_link)!)
        cell.configureCell()
        return cell
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        guard let popupViewController = segue.destination as? PopupViewController else { return }
        
        let data = events[currentIndex] as NSDictionary
        var image_link = data["imagename"] as! String
        image_link = baseURL + image_link
        popupViewController.imageurl = image_link
        popupViewController.titlecontent = data["title"] as! String
        
        popupViewController.customBlurEffectStyle = .light
        popupViewController.customAnimationDuration = 0.5
        popupViewController.customInitialScaleAmmount = 0.7
    }
}
class EventCollectionViewCell: UICollectionViewCell {
    var baseURL: String!
    var index: Int = -1
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var cellData : NSDictionary = [:]
    var collectionViewController : EventViewController!
    func configureCell(){
        titleLabel.text = cellData["title"] as? String
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
//        var alert = UIAlertController(title: cellData["title"] as? String,
//                                      message: "",
//                                      preferredStyle: .alert)
        // Your action
//        var imageView = UIImageView(frame: CGRect(x:0, y:60, width:400, height:600))
//        imageView.af_setImage(withURL: URL(string: self.baseURL+(cellData["imagename"] as! String))!)
        collectionViewController.currentIndex = index
        collectionViewController.performSegue(withIdentifier: "eventPopup", sender: self)
    }
    
    
    
    @IBAction func onDetail(_ sender: Any) {
        collectionViewController.configureBackButton()
        appDelegate.eventdetailVC.title = cellData["title"] as! String
        appDelegate.eventdetailVC.linkurl = cellData["link"] as! String
        collectionViewController.navigationController?.pushViewController(appDelegate.eventdetailVC, animated: true)
    }
}
