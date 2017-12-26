//
//  LocationViewController.swift
//  Montreal
//
//  Created by Colin Taylor on 3/9/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import Foundation
import MapKit
public class LocationViewController: UIViewController,MKMapViewDelegate {
    var latitude : String = "", longitude : String = ""
    @IBOutlet weak var mapView: MKMapView!
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("LocationViewController awake from nib")
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        /*let placemark = CLPlacemark()
        placemark.location = CLLocation(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
        self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)*/
        addressToCoordinatesConverter()
    }
    func addressToCoordinatesConverter() {
        //let geoCoder = CLGeocoder()
        let newlocation = CLLocation(latitude: (self.latitude as NSString).doubleValue, longitude:(self.longitude as NSString).doubleValue )
        
        let placemark = MKPlacemark(coordinate: newlocation.coordinate)
        self.mapView.addAnnotation(placemark)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    public func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
    }
}
