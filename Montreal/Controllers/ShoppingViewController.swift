//
//  ShoppingViewController.swift
//  Montreal
//
//  Created by William Andersson on 5/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class ShoppingViewController: TabmanViewController, PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return 2
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        let vc1 = (storyboard?.instantiateViewController(withIdentifier: "allMallsViewController"))! as! AllMallsViewController
        let vc2 = (storyboard?.instantiateViewController(withIdentifier: "rentViewController"))! as! RentViewController
        if (index == 0) {
            return vc1
        } else {
            return vc2
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.bar.items = [Item(title: "ALL MALLS"),
                          Item(title: "RENT A SPACE")]
    }
    
    func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
        // use default index
        return nil
    }
}
