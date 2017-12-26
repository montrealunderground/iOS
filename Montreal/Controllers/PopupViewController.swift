//
//  PopupViewController.swift
//  MIBlurPopup
//
//  Created by Mario on 14/01/2017.
//  Copyright © 2017 Mario. All rights reserved.
//

import UIKit
import MIBlurPopup

class PopupViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        imageView.af_setImage(withURL: URL(string:imageurl)!)
        titleLabel.text = titlecontent
    }
    // MARK: - IBOutlets
    
    
    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            dismissButton.layer.cornerRadius = dismissButton.frame.height/2
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!{
        didSet {
            imageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var popupContentContainerView: UIView!
    
    var imageurl: String!
    var titlecontent: String!
    
    var customBlurEffectStyle: UIBlurEffectStyle!
    var customInitialScaleAmmount: CGFloat!
    var customAnimationDuration: TimeInterval!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return customBlurEffectStyle == .dark ? .lightContent : .default
    }
    
    // MARK: - IBActions
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
    
        dismiss(animated: true)
    
    }

}

// MARK: - MIBlurPopupDelegate

extension PopupViewController: MIBlurPopupDelegate {
    
    var popupView: UIView {
        return popupContentContainerView ?? UIView()
    }
    var blurEffectStyle: UIBlurEffectStyle {
        return customBlurEffectStyle
    }
    var initialScaleAmmount: CGFloat {
        return customInitialScaleAmmount
    }
    var animationDuration: TimeInterval {
        return customAnimationDuration
    }
    
}
