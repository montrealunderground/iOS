//
//  PlacesViewController1.swift
//  Montreal
//
//  Created by William Andersson on 5/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//


import UIKit
import Tabman
import Pageboy
enum PlacesMode:UInt {
    case Restaurants = 0, Boutiques, BeautyHealth, Attractions, Stores
}
class PlacesViewController: TabmanViewController, PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return 3
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        switch(index) {
        case 0:
            return allPlaceViewController
        case 1:
            return metroPlaceViewController
        case 2:
            return mallListViewController
        default:
            return allPlaceViewController
        }
        
//        // configure the bar, ,
//        self.bar.items = [Item(title: "ALL"),
//                          Item(title: "BY METRO"),
//                          Item(title: "BY MALL")]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    
    struct GradientConfig {
        let topColor: UIColor
        let bottomColor: UIColor
        
        static var defaultGradient: GradientConfig {
            return GradientConfig(topColor: .black, bottomColor: .black)
        }
    }
    
    var mode : PlacesMode = .Restaurants
    var allPlaceViewController = PlaceListViewController()
    var metroPlaceViewController = MetroViewController()
    var mallListViewController = MallListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupView()
    }
    
    func setupViewControllers() {
        allPlaceViewController = self.storyboard?.instantiateViewController(withIdentifier: "placeListViewController") as! PlaceListViewController
        allPlaceViewController.setSpacing = true
        metroPlaceViewController = self.storyboard?.instantiateViewController(withIdentifier: "metroListViewController") as! MetroViewController
        mallListViewController = self.storyboard?.instantiateViewController(withIdentifier: "mallListViewController") as! MallListViewController
    }
    func setupView() {
        self.title = NSLocalizedString("Shopping Malls", comment:"Shopping Malls")
        
        self.dataSource = self
        self.bar.location = .top
        self.bar.style = .buttonBar
        let appearance = self.bar.appearance ?? TabmanBar.Appearance.defaultAppearance
        appearance.indicator.bounces = false
        appearance.state.color = UIColor.white
        appearance.state.selectedColor = UIColor.white
        appearance.style.background = .solid(color: UIColor(red: 0.078125, green: 0.1796875, blue: 0.234375, alpha: 1.0))
        appearance.indicator.color = UIColor(red:0.25, green:0.765625, blue:1.0, alpha:1.0)
        appearance.indicator.lineWeight = .thick
        appearance.indicator.compresses = true
        appearance.layout.edgeInset = 0.0
        appearance.layout.interItemSpacing = 0.0
        self.bar.appearance = appearance
        self.bar.items = [Item(title: "ALL"),Item(title: "BY METRO"),Item(title: "BY MALL")]
    }
    
//    func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
//        // return array of view controllers
//        print("PlacesViewController : forPageboyViewController")
//        let viewControllers = [allPlaceViewController, metroPlaceViewController, mallListViewController] as [UIViewController]
//
//        // configure the bar, ,
//        self.bar.items = [Item(title: "ALL"),
//                          Item(title: "BY METRO"),
//                          Item(title: "BY MALL")]
//
//        return viewControllers
//    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allPlaceViewController.mode = self.mode
        self.mallListViewController.mode = self.mode
        NSLog("PlacesViewController : viewWillAppear")
        switch mode {
        case .Attractions:
            self.navigationItem.title = NSLocalizedString("Attractions", comment:"Attractions")
            //self.titleLabel.text = NSLocalizedString("Attractions", comment:"Attractions")
            getAttractions()
            break
        case .BeautyHealth:
            self.navigationItem.title = NSLocalizedString("Beauty & Health", comment:"Beauty & Health")
            //self.titleLabel.text = NSLocalizedString("Beauty & Health", comment:"Beauty & Health")
            getBeautyAndHealth()
            break
        case .Boutiques:
            self.navigationItem.title = NSLocalizedString("Boutiques", comment:"Boutiques")
            //self.titleLabel.text = NSLocalizedString("Boutiques", comment:"Boutiques")
            getBoutiques()
            break
        case .Restaurants:
            self.navigationItem.title = NSLocalizedString("Restaurants", comment:"Restaurants")
            //self.titleLabel.text = NSLocalizedString("Restaurants", comment:"Restaurants")
            getRestaurants()
            break
        case .Stores:
            self.navigationItem.title = NSLocalizedString("Stores", comment:"Stores")
            //self.titleLabel.text = NSLocalizedString("Stores", comment:"Stores")
            getStores()
        }
        self.allPlaceViewController.mode = self.mode
        self.mallListViewController.mode = self.mode
    }
    func getRestaurants(){
        NetworkManger.sharedInstance.getStoresAPI(parameters: ["type":NSLocalizedString("Restaurant", comment:"Restaurant")]) { (json, status) in
            print(json)
            let stores = json["stores"] as! [NSDictionary]
            self.allPlaceViewController.list = stores
            self.allPlaceViewController.mode = self.mode
            self.allPlaceViewController.baseURL = json["download_prefix_store"] as! String
            self.allPlaceViewController.coverphotoURL = json["download_prefix_store_coverphoto"] as! String
            self.allPlaceViewController.tableView.reloadData()
        }
        NetworkManger.sharedInstance.getMetroListForStoreAPI(parameters: ["type":NSLocalizedString("Restaurant", comment:"Restaurant")]) { (json, status) in
            print(json)
            let metros = json["metros"] as! [NSDictionary]
            self.metroPlaceViewController.list = metros
            self.metroPlaceViewController.mode = self.mode
        }
    }
    func getStores(){
        NetworkManger.sharedInstance.getStoresAPI(parameters: [:]) { (json, status) in
            print(json)
            let stores = json["stores"] as! [NSDictionary]
            self.allPlaceViewController.list = stores
            self.allPlaceViewController.mode = self.mode
            self.allPlaceViewController.baseURL = json["download_prefix_store"] as! String
            self.allPlaceViewController.coverphotoURL = json["download_prefix_store_coverphoto"] as! String
            self.allPlaceViewController.tableView.reloadData()
        }
        NetworkManger.sharedInstance.getMetroListForStoreAPI(parameters: ["type":NSLocalizedString("Attraction", comment:"Attraction")]) { (json, status) in
            print(json)
            let metros = json["metros"] as! [NSDictionary]
            self.metroPlaceViewController.list = metros
            self.metroPlaceViewController.mode = self.mode
            //self.metroPlaceViewController.tableView.reloadData()
        }
    }
    func getBoutiques(){
        NetworkManger.sharedInstance.getStoresAPI(parameters: ["type":NSLocalizedString("Boutique", comment:"Boutique")]) { (json, status) in
            print(json)
            let stores = json["stores"] as! [NSDictionary]
            self.allPlaceViewController.list = stores
            self.allPlaceViewController.mode = self.mode
            self.allPlaceViewController.baseURL = json["download_prefix_store"] as! String
            self.allPlaceViewController.coverphotoURL = json["download_prefix_store_coverphoto"] as! String
            self.allPlaceViewController.tableView.reloadData()
        }
        NetworkManger.sharedInstance.getMetroListForStoreAPI(parameters: [:]) { (json, status) in
            print(json)
            let metros = json["metros"] as! [NSDictionary]
            self.metroPlaceViewController.list = metros
            self.metroPlaceViewController.mode = self.mode
            //self.metroPlaceViewController.tableView.reloadData()
        }
    }
    func getBeautyAndHealth(){
        NetworkManger.sharedInstance.getStoresAPI(parameters: ["type":NSLocalizedString("Beauty & Health", comment:"Beauty & Health")]) { (json, status) in
            print(json)
            let stores = json["stores"] as! [NSDictionary]
            self.allPlaceViewController.list = stores
            self.allPlaceViewController.mode = self.mode
            self.allPlaceViewController.baseURL = json["download_prefix_store"] as! String
            self.allPlaceViewController.coverphotoURL = json["download_prefix_store_coverphoto"] as! String
            self.allPlaceViewController.tableView.reloadData()
        }
        NetworkManger.sharedInstance.getMetroListForStoreAPI(parameters: [:]) { (json, status) in
            print(json)
            let metros = json["metros"] as! [NSDictionary]
            self.metroPlaceViewController.list = metros
            self.metroPlaceViewController.mode = self.mode
            //self.metroPlaceViewController.tableView.reloadData()
        }
    }
    func getAttractions(){
        NetworkManger.sharedInstance.getStoresAPI(parameters: ["type":NSLocalizedString("Attraction", comment:"Attraction")]) { (json, status) in
            print(json)
            let stores = json["stores"] as! [NSDictionary]
            self.allPlaceViewController.list = stores
            self.allPlaceViewController.mode = self.mode
            self.allPlaceViewController.baseURL = json["download_prefix_store"] as! String
            self.allPlaceViewController.coverphotoURL = json["download_prefix_store_coverphoto"] as! String
            self.allPlaceViewController.tableView.reloadData()
        }
        NetworkManger.sharedInstance.getMetroListForStoreAPI(parameters: [:]) { (json, status) in
            print(json)
            let metros = json["metros"] as! [NSDictionary]
            self.metroPlaceViewController.list = metros
            self.metroPlaceViewController.mode = self.mode
            //self.metroPlaceViewController.tableView.reloadData()
        }
    }
}
