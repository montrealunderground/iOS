//
//  PlacesViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
/*enum PlacesMode:UInt {
    case Restaurants = 0, Boutiques, BeautyHealth, Attractions, Stores
}*/
public class PlacesViewController_old: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout/*, TabBarDelegate */{
    var mode : PlacesMode = .Restaurants
    var views = [UIView]()
    let items = ["ALL", "BY METRO", "BY MALL"]
    var allPlaceViewController = PlaceListViewController()
    var metroPlaceViewController = MetroViewController()
    var mallListViewController = MallListViewController()
    let storyboardItems = ["placeListViewController","metroListViewController","mallListViewController"]
    var viewsAreInitialized = false
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 56, width: UIScreen.main.bounds.width, height: (self.view.bounds.height)), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.clear
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.isDirectionalLockEnabled = true
        return cv
    }()
    lazy var tabBar: TabBar = {
        let tb = TabBar.init(frame: CGRect.init(x: 0, y: 56, width: UIScreen.main.bounds.width, height: 56))
        tb.delegate = self
        tb.items = self.items
        tb.storyboardItems = self.storyboardItems
        tb.configureWhiteView()
        return tb
    }()
    let titleLabel: UILabel = {
        let tl = UILabel.init(frame: CGRect.init(x: 20, y: 5, width: 200, height: 30))
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.textColor = UIColor.white
        return tl
    }()
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("PlacesViewController awake from nib")
    }
    
    override public func viewDidLoad() {
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        super.viewDidLoad()
        customization()
        didSelectItem(atIndex: 0)
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allPlaceViewController.mode = self.mode
        self.mallListViewController.mode = self.mode
        NSLog("PlacesViewController will appear")
        switch mode {
        case .Attractions:
            self.navigationItem.title = NSLocalizedString("Attractions", comment:"Attractions")
            self.titleLabel.text = NSLocalizedString("Attractions", comment:"Attractions")
            getAttractions()
            break
        case .BeautyHealth:
            self.navigationItem.title = NSLocalizedString("Beauty & Health", comment:"Beauty & Health")
            self.titleLabel.text = NSLocalizedString("Beauty & Health", comment:"Beauty & Health")
            getBeautyAndHealth()
            break
        case .Boutiques:
            self.navigationItem.title = NSLocalizedString("Boutiques", comment:"Boutiques")
            self.titleLabel.text = NSLocalizedString("Boutiques", comment:"Boutiques")
            getBoutiques()
            break
        case .Restaurants:
            self.navigationItem.title = NSLocalizedString("Restaurants", comment:"Restaurants")
            self.titleLabel.text = NSLocalizedString("Restaurants", comment:"Restaurants")
            getRestaurants()
            break
        case .Stores:
            self.navigationItem.title = NSLocalizedString("Stores", comment:"Stores")
            self.titleLabel.text = NSLocalizedString("Stores", comment:"Stores")
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
            self.metroPlaceViewController.tableView.reloadData()
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
            self.metroPlaceViewController.tableView.reloadData()
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
            self.metroPlaceViewController.tableView.reloadData()
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
            self.metroPlaceViewController.tableView.reloadData()
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
            self.metroPlaceViewController.tableView.reloadData()
        }
    }
    //MARK: Methods
    func customization()  {
        
        //CollectionView Customization
        self.collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        self.view.addSubview(self.collectionView)
        
        //NavigationController Customization
        //        self.navigationController?.view.backgroundColor = UIColor.rbg(r: 228, g: 34, b: 24)
        //        self.navigationController?.navigationItem.hidesBackButton = true
        //        self.navigationItem.hidesBackButton = true
        //
        //        //NavigationBar color and shadow
        //        self.navigationController?.navigationBar.barTintColor = UIColor.rbg(r: 228, g: 34, b: 24)
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        //
        // TitleLabel
        
        //TabBar
        self.view.addSubview(self.tabBar)
        
        //ViewControllers init
        allPlaceViewController = self.storyboard?.instantiateViewController(withIdentifier: "placeListViewController") as! PlaceListViewController
        metroPlaceViewController = self.storyboard?.instantiateViewController(withIdentifier: "metroListViewController") as! MetroViewController
        mallListViewController = self.storyboard?.instantiateViewController(withIdentifier: "mallListViewController") as! MallListViewController
        
        self.addChildViewController(allPlaceViewController)
        allPlaceViewController.view.frame = CGRect.init(x: 0, y: 30, width: self.view.bounds.width, height: (self.view.bounds.height - 64))
        allPlaceViewController.didMove(toParentViewController: self)
        
        self.addChildViewController(metroPlaceViewController)
        metroPlaceViewController.view.frame = CGRect.init(x: 0, y: 30, width: self.view.bounds.width, height: (self.view.bounds.height - 64))
        metroPlaceViewController.didMove(toParentViewController: self)
        
        self.addChildViewController(mallListViewController)
        mallListViewController.view.frame = CGRect.init(x: 0, y: 30, width: self.view.bounds.width, height: (self.view.bounds.height - 64))
        mallListViewController.didMove(toParentViewController: self)
        
        self.views.append(allPlaceViewController.view)
        self.views.append(metroPlaceViewController.view)
        self.views.append(mallListViewController.view)
        self.viewsAreInitialized = true
    }
    //MARK: Delegates implementation
    public func didSelectItem(atIndex: Int) {
        self.collectionView.scrollRectToVisible(CGRect.init(origin: CGPoint.init(x: (self.view.bounds.width * CGFloat(atIndex)), y: 0), size: self.view.bounds.size), animated: true)
    }
    func pushViewController(_ sender: AnyObject) {
        let viewController = UIViewController.init()
        viewController.title = "Pushed Controller"
        viewController.view.backgroundColor = UIColor.white
        configureBackButton()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("ShoppingViewController will disappear")
    }
    //MARK: CollectionView DataSources
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.addSubview(self.views[indexPath.row])
        return cell
    }
    
    //MARK: CollectionView Delegates
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.bounds.width, height: (self.view.bounds.height + 22))
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollIndex = Int(round(scrollView.contentOffset.x / self.view.bounds.width))
        if self.viewsAreInitialized {
            self.tabBar.whiteView.frame.origin.x = (scrollView.contentOffset.x / 3)
            //            self.tabBar.highlightItem(atIndex: scrollIndex)
        }
    }
    
}
