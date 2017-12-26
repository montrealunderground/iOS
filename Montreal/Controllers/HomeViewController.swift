//
//  FirstViewController.swift
//  AKSideMenuSimple
//
//  Created by Diogo Autilio on 6/6/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import UIKit
import GoogleMobileAds

var menu_images: [UIImage] = [ UIImage(named: "map-back")!,
                               UIImage(named: "ar-back")!,
                               UIImage(named: "metro-back")!,
                               UIImage(named: "malls")!,
                               UIImage(named: "resto-back")!,
                               UIImage(named: "boutiques")!,
                               UIImage(named: "bh")!,
                               UIImage(named: "attractions-back")!,
                               UIImage(named: "services-back")!,
                               UIImage(named: "hotel-back")!,
                               UIImage(named: "events-back")!,
                               UIImage(named: "promo-back")!]
var menu_icons: [UIImage] = [UIImage(named: "map-icon")!,
                             UIImage(named: "ar_icon")!,
                             UIImage(named: "metro_icon")!,
                             UIImage(named: "tower-icon")!,
                             UIImage(named: "resto-icon")!,
                             UIImage(named: "boutique-icon")!,
                             UIImage(named: "beauty-icon")!,
                             UIImage(named: "attractions-icon")!,
                             UIImage(named: "services-icon")!,
                             UIImage(named: "hotel-icon")!,
                             UIImage(named: "events-icon")!,
                             UIImage(named: "coins-icon")!]
var bannerimages : [NSDictionary] = []
var baseURL : String = ""

public class HomeViewController: AdViewController, GADInterstitialDelegate, UIGestureRecognizerDelegate {
    
    var interstitial: GADInterstitial!
    static func createFromStoryboard() -> HomeViewController {
        let storyboard = UIStoryboard(name: "homeViewController", bundle: nil)
        return storyboard.instantiateInitialViewController() as! HomeViewController
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
        }
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        createAndLoadInterstitial()
        NetworkManger.sharedInstance.getBannerImagesAPI(parameters: [:]) { (json, status) in
            print(json)
            baseURL = json["download_prefix_bannerimage"] as! String
            bannerimages = json["bannerimages"] as! [NSDictionary]
            self.tableView?.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didUndergroundMapClicked), name: NSNotification.Name(rawValue: notificationDidUndergroundClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didARListClicked), name: NSNotification.Name(rawValue: notificationDidARListClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didMetroPlanClicked), name: NSNotification.Name(rawValue: notificationDidMetroPlanClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didShoppingMallsClicked), name: NSNotification.Name(rawValue: notificationDidShoppingMallsClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRestaurantsClicked), name: NSNotification.Name(rawValue: notificationDidRestaurantsClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBoutiquesClicked), name: NSNotification.Name(rawValue: notificationDidBoutiquesClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBeautyHealthClicked), name: NSNotification.Name(rawValue: notificationDidBeautyHealthClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didAttractionsClicked), name: NSNotification.Name(rawValue: notificationDidAttractionsClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didServicesJobsClicked), name: NSNotification.Name(rawValue: notificationDidServicesJobsClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didHotelsClicked), name: NSNotification.Name(rawValue: notificationDidHotelsClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEventsClicked), name: NSNotification.Name(rawValue: notificationDidEventsClicked), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didUnderCoinsClicked), name: NSNotification.Name(rawValue: notificationDidUnderCoinsClicked), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(didPromotionsClicked), name: NSNotification.Name(rawValue: notificationDidPromotionsClicked), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidUndergroundClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidARListClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidMetroPlanClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidShoppingMallsClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidRestaurantsClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidBoutiquesClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidBeautyHealthClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidAttractionsClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidServicesJobsClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidHotelsClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidEventsClicked), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationDidUnderCoinsClicked), object: nil)
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDelegate.onOpenVC(vc: appDelegate.homeVC)
    }
    func showInterstitialAds(name: String!) {
        if (appDelegate.interstitialAdsState.object(forKey: name) != nil && (appDelegate.interstitialAdsState.object(forKey: name) as! String) == "1") {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        } else {
            print("Not showing interstitial Ads")
        }
    }
    
    public func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        createAndLoadInterstitial()
    }
    
    fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: NSLocalizedString(Constants.INTERSTITIAL_ADS_UNIT_ID, comment: ""))
        let request = GADRequest()
        interstitial.load(request)
    }
    public func didUndergroundMapClicked(){
        configureBackButton()
        showInterstitialAds(name: "UndergroundViewController")
        appDelegate.undergroundVC.hideBackButton(hidden:false)
        appDelegate.undergroundVC.destination = ""
        self.navigationController?.pushViewController(appDelegate.undergroundVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.undergroundVC)
    }
    public func didARListClicked() {
        configureBackButton()
        showInterstitialAds(name: "ARListViewController")
        appDelegate.arVC.hideBackButton(hidden:false)
        self.navigationController?.pushViewController(appDelegate.arVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.arVC)
    }
    public func didMetroPlanClicked() {
        configureBackButton()
        showInterstitialAds(name: "MetroPlanViewController")
        appDelegate.metroVC.hideBackButton(hidden:false)
        self.navigationController?.pushViewController(appDelegate.metroVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.metroVC)
    }
    public func didShoppingMallsClicked(){
        configureBackButton()
        showInterstitialAds(name: "ShoppingViewController")
        appDelegate.shoppingVC.hideBackButton(hidden:false)
        self.navigationController?.pushViewController(appDelegate.shoppingVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.shoppingVC)
    }
    public func didRestaurantsClicked(){
        didStoreClicked(PlacesMode.Restaurants)
    }
    public func didBoutiquesClicked(){
        didStoreClicked(PlacesMode.Boutiques)
    }
    public func didBeautyHealthClicked(){
        didStoreClicked(PlacesMode.BeautyHealth)
    }
    public func didAttractionsClicked(){
        didStoreClicked(PlacesMode.Attractions)
    }
    func didStoreClicked(_ mode: PlacesMode) {
        self.configureBackButton()
        showInterstitialAds(name: "PlacesViewController")
        appDelegate.placesVC.mode = mode
        appDelegate.placesVC.hideBackButton(hidden:false)
        self.navigationController?.pushViewController(appDelegate.placesVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.placesVC)
    }
    public func didServicesJobsClicked(){
        configureBackButton()
        showInterstitialAds(name: "JobsViewController")
        appDelegate.jobsVC.hideBackButton(hidden:false)
        self.navigationController?.pushViewController(appDelegate.jobsVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.jobsVC)
    }
    public func didHotelsClicked(){
        configureBackButton()
        showInterstitialAds(name: "HotelsViewController")
        appDelegate.hotelsVC.hideBackButton(hidden:false)
        self.navigationController?.pushViewController(appDelegate.hotelsVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.hotelsVC)
    }
    public func didEventsClicked(){
        configureBackButton()
        showInterstitialAds(name: "EventViewController")
        appDelegate.eventVC.hideBackButton(hidden:false)
        self.navigationController?.pushViewController(appDelegate.eventVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.eventVC)
    }
//    public func didPromotionsClicked(){
//        configureBackButton()
//        showInterstitialAds(name: "PromotionViewController")
//        appDelegate.promotionVC.hideBackButton(hidden:false)
//        self.navigationController?.pushViewController(appDelegate.promotionVC, animated: true)
//
//        appDelegate.onOpenVC(vc: appDelegate.promotionVC)
//    }
    public func didUnderCoinsClicked() {
        configureBackButton()
        showInterstitialAds(name: "UCStoreViewController")
        appDelegate.ucstoreVC.hideBackButton(hidden:false)
        self.navigationController?.pushViewController(appDelegate.ucstoreVC, animated: true)
        
        appDelegate.onOpenVC(vc: appDelegate.ucstoreVC)
    }
    public func configureBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    func respondToTapGesture(_ sender: UITapGestureRecognizer) {
        let bannerimage = bannerimages[sender.view!.tag]
        let link = (bannerimage["link"] as? String)!
        if (link.characters.count > 0 ) {
            let rentFormVC = self.storyboard?.instantiateViewController(withIdentifier: "rentFormViewController") as! RentFormViewController
            rentFormVC.titlename = (bannerimage["title"] as? String)!
            rentFormVC.url = (bannerimage["link"] as? String)!
            configureBackButton()
            self.navigationController?.pushViewController(rentFormVC, animated: true)
        } else {
            let alert = UIAlertController(title: NSLocalizedString("Cannot open the website", comment:"null link title"), message: NSLocalizedString("URL not specified", comment:"null link message"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:"ok"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1: return 1
        default: return 0
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfiniteTableViewCell.identifier) as! InfiniteTableViewCell
            cell.viewController = self
            cell.pageControl.numberOfPages = bannerimages.count
            cell.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
            
            cell.collectionView.reloadData()
            //cell.pageControl
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Infinite2TableViewCell.identifier) as! Infinite2TableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.size.width
        let height = width / (1242.0/708.0)
        switch indexPath.section {
        case 0:
            return height
            //return 240
        case 1: return 875
        default: return 0
        }
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension InfiniteTableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func number(ofItems collectionView: UICollectionView) -> Int {
        return bannerimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: dequeueIndexPath) as! ImageCollectionViewCell
        
        let bannerimage = bannerimages[usableIndexPath.row]
        var img_link = bannerimage["imagename"] as! String
        img_link = baseURL + img_link
        cell.imageView.af_setImage(withURL: URL(string: img_link)!)
        cell.imageView.tag = usableIndexPath.row
        
        var tapRecognizer: UITapGestureRecognizer!
        
        tapRecognizer = UITapGestureRecognizer(target: viewController , action: #selector(viewController?.respondToTapGesture(_:)))
        cell.imageView.isUserInteractionEnabled = true
        cell.imageView.addGestureRecognizer(tapRecognizer)
        
        tapRecognizer.delegate = appDelegate.homeVC
        
        cell.configure(indexPath: usableIndexPath)
        return cell
    }
    
    func scrollView(_ scrollView: UIScrollView, pageIndex: Int) {
        pageControl.currentPage = pageIndex
    }
}

final class InfiniteTableViewCell: UITableViewCell {
    static let identifier = "InfiniteTableViewCell"
    var viewController : HomeViewController? = nil
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    deinit {
        
    }
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        }
    }
    @IBOutlet weak var layout: UICollectionViewFlowLayout! {
        didSet {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 240)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = bannerimages.count
        }
    }
}

final class Infinite2TableViewCell: UITableViewCell {
    static let identifier = "Infinite2TableViewCell"
    override func awakeFromNib() {
        print("awake from nib")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    deinit {
        
    }
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!{
        didSet {
            collectionFlowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 16)/2, height: 140)
        }
    }
    @IBOutlet weak var collectionView: InfiniteCollectionView! {
        didSet {
            collectionView.infiniteDataSource = self
            collectionView.infiniteDelegate = self
            collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        }
    }
}

// MARK: - InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate
extension Infinite2TableViewCell: InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    func number(ofItems collectionView: UICollectionView) -> Int {
        return menu_images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, dequeueForItemAt dequeueIndexPath: IndexPath, cellForItemAt usableIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: dequeueIndexPath) as! ImageCollectionViewCell
        cell.imageView.image = menu_images[usableIndexPath.row]
        cell.titleLabel.text = NSLocalizedString(Constants.menu_titles[usableIndexPath.row], comment:Constants.menu_titles[usableIndexPath.row])
        cell.iconView.image = menu_icons[usableIndexPath.row]
        cell.configure(indexPath: usableIndexPath)
        return cell
    }
    func infiniteCollectionView(_ collectionView: UICollectionView, didSelectItemAt usableIndexPath: IndexPath) {
        print("didSelectItemAt: \(usableIndexPath.item)")
        switch usableIndexPath.row {
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidUndergroundClicked), object: nil)
            break
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidARListClicked), object: nil)
            break
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidMetroPlanClicked), object: nil)
            break
        case 3:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidShoppingMallsClicked), object: nil)
            break
        case 4:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidRestaurantsClicked), object: nil)
            break
        case 5:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidBoutiquesClicked), object: nil)
            break
        case 6:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidBeautyHealthClicked), object: nil)
            break
        case 7:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidAttractionsClicked), object: nil)
            break
        case 8:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidServicesJobsClicked), object: nil)
            break
        case 9:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidHotelsClicked), object: nil)
            break
        case 10:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidEventsClicked), object: nil)
            break
        case 11:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidUnderCoinsClicked), object: nil)
            break
//        case 11:
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationDidPromotionsClicked), object: nil)
//            break
        default:
            break
        }
    }
}
