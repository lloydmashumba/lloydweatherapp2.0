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
    
    var pinTitle : String?
    var lat : Double?
    var lon : Double?
    
    //MARK: Location
    var location :CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: lat ?? 0.0, longitude: lon ?? 0.0
        )
    }
    
    //pin
    private var annotation : MKPointAnnotation {
        
        let pin = MKPointAnnotation()
        pin.title = pinTitle ?? ""
        pin.coordinate = location
        return pin
    }
    //region
    private var region : MKCoordinateRegion {
        MKCoordinateRegion(center: location,
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        ))
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
        mapView.region = region
        mapView.addAnnotation(annotation)
    }
    
    
}
