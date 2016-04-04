//
//  MapController.swift
//  test
//
//  Created by Kimate Richards on 4/4/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import MapKit
import CoreLocation

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
        @IBOutlet weak var locationMap: MKMapView!
        @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listBtn: UIButton!
    
    let addressArray = [
        "607 Market Street, CA 94105",
        "101 Post St, San Francisco, CA 94108",
        "165 Post St, San Francisco, CA 94108"
    ]
    
    var fetchedLocation = [SWLocation]()
    var inSearchmode = false
    var filteredLocations = [SWLocation]()
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMap.delegate = self
        self.locationManager.delegate = self
        
        
        for address in addressArray {
            getPlacemarkFromAddress(address)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()

        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.startUpdatingLocation()
        self.locationMap.showsUserLocation = true
    }
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationMap.showsUserLocation = true
        }else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2,
                                                                  regionRadius * 2)
        locationMap.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let cent = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.latitude)
        
        let region = MKCoordinateRegion(center: cent, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.locationMap.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(LocationAnnotations) {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annotationView.pinTintColor = UIColor.blueColor()
            annotationView.animatesDrop = true
            return annotationView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            centerMapOnLocation(loc)
        }
    }
    
    func createLocationAnnotationForLocation(location: CLLocation){
        let location = LocationAnnotations(coordinate: location.coordinate)
        locationMap.addAnnotation(location)
    }
    
    func getPlacemarkFromAddress(address: String){
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    self.createLocationAnnotationForLocation(loc)
                }
            }
        }
    }

}
