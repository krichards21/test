//
//  SWLocation.swift
//  test
//
//  Created by Kimate Richards on 3/11/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import Foundation
import CoreData

class SWLocation: NSManagedObject {
    @NSManaged var locationID: Int
    @NSManaged var locationName: String!
    @NSManaged var _address1: String!
    @NSManaged var _address2: String!
    @NSManaged var _address3: String!
    @NSManaged var _city: String!
    @NSManaged var _state: String!
    @NSManaged var _postalCode: String!
    @NSManaged var _LocationID: Int32
    @NSManaged var _LocationName: String!
    @NSManaged var _hoursStart: String!
    @NSManaged var _hoursEnd: String!
    @NSManaged var _daysOpen: String!
    @NSManaged var _googleMapsSmall: String!
    @NSManaged var _googleMapsMedium: String!
    @NSManaged var imageURL: String!

    
//    var locationID: Int32{
//        get {
//            return _locationID
//        }
//    }
//    
//    var locationName: String{
//        get {
//            return _locationName
//        }
//    }
//    
//    var address1: String{
//        get {
//            return _address1
//        }
//    }
//    
//    var address2: String{
//        get {
//            return _address2
//        }
//    }
//    
//    var address3: String{
//        get {
//            return _address3
//        }
//    }
//    
//    var city: String{
//        get {
//            return _city
//        }
//    }
//    
//    var postalCode: String{
//        get {
//            return _postalCode
//        }
//    }
//    
//    var state: String{
//        get {
//            return _state
//        }
//    }
//    
//    var hoursStart: String{
//        get {
//            return _hoursStart
//        }
//    }
//    
//    var hoursEnd: String{
//        get {
//            return _hoursEnd
//        }
//    }
//    
//    var daysOpen: String{
//        get {
//            return _daysOpen
//        }
//    }
//    
//    var googleMapsSmall: String{
//        get {
//            return _googleMapsSmall
//        }
//    }
//    
//    var googleMapsMedium: String{
//        get {
//            return _googleMapsMedium
//        }
//    }
//    
//    var imageURL: String{
//        get {
//            return _imageURL
//        }
//    }
//    
//    init(locationName: String, address1: String, address2: String, address3: String, city: String, state: String, postalCode: String, locationID: Int32, googleMapsSmall: String, googleMapsMedium: String, hoursStart: String, hoursEnd: String, daysOpen: String, imageURL: String){
//        self._LocationID = locationID
//        _locationName = locationName
//        _address1 = address1
//        _address2 = address2
//        _address3 = address3
//        _city = city
//        _state = state
//        _postalCode = postalCode
//        _hoursStart = hoursStart
//        _hoursEnd = hoursEnd
//        _daysOpen = daysOpen
//        _googleMapsSmall = googleMapsSmall
//        _googleMapsMedium = googleMapsMedium
//        _imageURL = imageURL
//    }
}
