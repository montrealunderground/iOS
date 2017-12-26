
//
//  ViewController.swift
//  SearchTest
//
//  Created by William Andersson on 3/22/17.
//  Copyright © 2017 William Andersson. All rights reserved.

import UIKit

protocol SearchViewControllerDelegate {
    func showPlaceDetailViewController(place: NSDictionary)
    func showWebViewController(title:String, link:String)
}

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SearchViewControllerDelegate?
    
    var filtered:[NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        searchBar.tintColor = UIColor.darkGray
        
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //print("searchBarTextDidBeginEditing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //print("searchBarTextDidEndEditing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("onCancel")
        self.view.removeFromSuperview()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
    }
    
    @IBOutlet var tapgesture: UITapGestureRecognizer!
    @IBAction func onTapTableView(_ sender: Any) {
        let point:CGPoint = tapgesture.location(in: self.tableView)
        let indexpath = self.tableView.indexPathForRow(at: point)
        if (indexpath == nil) {
            print("onCancel")
            self.view.removeFromSuperview()
        } else {
            self.tableView(self.tableView, didSelectRowAt: indexpath!)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (((searchText as NSString).replacingOccurrences(of: " ", with: "")).characters.count > 0) {
            print(searchText)
            NetworkManger.sharedInstance.getSearchAPI(query: searchText, pagenum: 0) { (json, status) in
                self.filtered.removeAll()
                let records = json["records"] as! NSDictionary
                let stores = records["stores"] as! [NSDictionary]
                self.filtered.append(contentsOf: stores)
//                for i in 0..<stores.count {
//                    let row:NSMutableDictionary = [:]
//                    let data:NSDictionary = stores[i]
//                    //row.
//                    row.setValue(data["name"] as! String , forKey: "name")
//                    row.setValue(data["link"] as! String , forKey: "link")
//                    self.filtered.append(row)
//                }
                
                self.tableView.reloadData()
                let infos = json["info"] as! NSDictionary
                let infostores = infos["stores"] as! NSDictionary
                let pagecount:Int = infostores.value(forKey: "num_pages") as! Int
                if (pagecount>=2) {
                    for i in 2..<(pagecount+1) {
                        NetworkManger.sharedInstance.getSearchAPI(query: searchText, pagenum: i) { (json, status) in
                            let records = json["records"] as! NSDictionary
                            let stores = records["stores"] as! [NSDictionary]
//                            for i in 0..<stores.count {
//                                self.filtered.append(stores[i] as! NSMutableDictionary)
//                            }
                            self.filtered.append(contentsOf: stores)
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        } else {
            self.filtered.removeAll()
            self.tableView.reloadData() 
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filtered.count)
        return filtered.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! SearchListCell
        let cellData = filtered[indexPath.row] as! NSDictionary
        cell.configureCell(data: cellData )
        return cell;
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = filtered[indexPath.row] as! NSDictionary
        self.view.removeFromSuperview()
        self.delegate?.showPlaceDetailViewController(place: place)
        
//        print(cellData)
//        let link = cellData.value(forKey: "link") as! String
//        if (link.characters.count > 0 ) {
//            self.view.removeFromSuperview()
//            self.delegate?.showWebViewController(title:cellData.value(forKey: "name") as! String, link: cellData.value(forKey: "link") as! String)
//        } else {
//            let alert = UIAlertController(title: NSLocalizedString("Cannot open the website", comment:"null link title"), message: NSLocalizedString("URL not specified", comment:"null link message"), preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:"ok"), style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
}
class SearchListCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    var cellData : NSDictionary = [:]
    func configureCell(data: NSDictionary){
        cellData = data
        titleLabel.text = cellData.value(forKey: "name") as! String
    }
    
}


