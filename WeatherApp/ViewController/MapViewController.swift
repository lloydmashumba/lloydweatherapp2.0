//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 8/11/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let mapView : MKMapView = {
        
        let map = MKMapView()
        return map
        
    }()
    
    //MARK: properties
    var pinTitle : String?
    var lat : Double?
    var lon : Double?
    
    //MARK: Location
    private var annotation : MKPointAnnotation {
        
        let pin = MKPointAnnotation()
        pin.title = pinTitle ?? ""
        pin.coordinate = CLLocationCoordinate2D(
            latitude: lat ?? 0.0, longitude: lon ?? 0.0
        )
        return pin
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        // constrain view
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //add annotation
        mapView.addAnnotation(annotation)
    }
    
    
}
