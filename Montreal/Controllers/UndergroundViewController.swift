//
//  LeftMenuViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/8/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//


import UIKit

class UndergroundViewController: AdViewController, VMEMapListener {
    
    @IBOutlet weak var mMapView: VMEMapView!
    var destination: String! = ""
    
    var isStart : Bool! = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isStart = true
        mMapView.mapListener = self
        mMapView.loadMap()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("UndergroundViewController will appear")
        if (isStart == false) {
            let cameraUpdate = VMECameraUpdate.init(forPlaceID: destination) as VMECameraUpdate
            mMapView.animateCamera(cameraUpdate)
        } else {
            isStart = false
        }
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("UndergroundViewController will disappear")
    }
    
    public func mapDidLoad(_ mapView: VMEMapView) {
        print("mapDidLoad")
        if (destination.characters.count > 0) {
            let cameraUpdate = VMECameraUpdate.init(forPlaceID: destination) as VMECameraUpdate
            mapView.updateCamera(cameraUpdate)
        }
    }
}
