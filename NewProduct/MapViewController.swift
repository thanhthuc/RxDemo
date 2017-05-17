//
//  MapViewController.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 19/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift
import RxCocoa

struct MapPoint {
   var longitute: Double = 0
   var latitute: Double = 0
}

class MapViewController: UIViewController {
   
   var mapPoint: MapPoint!
   var locationManager = CLLocationManager()
   
   @IBOutlet weak var mapView: MKMapView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
      
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}

class CustomPointAnnotation: MKPointAnnotation {
   var pinCustomImageName:String!
}

extension MapViewController: MKMapViewDelegate {
   
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let reuseIdentifier = "pin"
      
      var v = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
      if v == nil {
         v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
         v!.canShowCallout = true
      }
      else {
         v!.annotation = annotation
      }
      v?.tintColor = UIColor.green
      v!.image = UIImage(named: "Cart")
      
      return v
   }
}

extension MapViewController: CLLocationManagerDelegate {
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let center = CLLocationCoordinate2D(latitude: mapPoint.latitute, longitude: mapPoint.longitute)
      let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
      self.mapView.setRegion(region, animated: true)
   }
   
}



