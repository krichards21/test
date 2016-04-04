//
//  LocationAnnotations.swift
//  test
//
//  Created by Kimate Richards on 4/4/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import MapKit

class LocationAnnotations: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
