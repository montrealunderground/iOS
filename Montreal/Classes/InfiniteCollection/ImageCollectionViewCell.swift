//
//  ImageCollectionViewCell.swift
//  Example
//
//  Created by hiroyuki yoshida on 2016/01/04.
//  Copyright © 2016年 hiroyuki yoshida. All rights reserved.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var iconView : UIImageView = {
        let iv = UIImageView.init(frame: CGRect.init(x: 68, y: 30, width: 44, height: 44))
        return iv
    }()
    let titleLabel: UILabel = {
        let tl = UILabel.init(frame: CGRect.init(x: 0, y: 85, width: 180, height: 30))
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.textColor = UIColor.white
        tl.textAlignment = .center
        return tl
    }()
    static let identifier = "ImageCollectionViewCell"
    static let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    func configure(indexPath: IndexPath) {
        var frame = iconView.frame
        frame.origin.x = (self.frame.width - 44)/2
        iconView.frame = frame
        frame = titleLabel.frame
        frame.origin.x = (self.frame.width - 180)/2
        titleLabel.frame = frame
        
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
