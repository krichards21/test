//
//  SWLocation.swift
//  test
//
//  Created by Kimate Richards on 3/11/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import Foundation

class SWLocation {
    private var _locationID: Int!
    private var _locationName: String!
    private var _address1: String!
    private var _address2: String!
    private var _address3: String!
    private var _city: String!
    private var _state: String!
    private var _postalCode: String!
    private var _LocationID: Int!
    private var _LocationName: String!
    private var _hoursStart: String!
    private var _hoursEnd: String!
    private var _daysOpen: String!
    private var _googleMapsSmall: String!
    private var _googleMapsMedium: String!
    
    var locationID: Int{
        get {
            return _locationID
        }
    }
    
    var locationName: String{
        get {
            return _locationName
        }
    }
    
    var address1: String{
        get {
            return _address1
        }
    }
    
    var address2: String{
        get {
            return _address2
        }
    }
    
    var address3: String{
        get {
            return _address3
        }
    }
    
    var city: String{
        get {
            return _city
        }
    }
    
    var postalCode: String{
        get {
            return _postalCode
        }
    }
    
    var state: String{
        get {
            return _state
        }
    }
    
    var hoursStart: String{
        get {
            return _hoursStart
        }
    }
    
    var hoursEnd: String{
        get {
            return _hoursEnd
        }
    }
    
    var daysOpen: String{
        get {
            return _daysOpen
        }
    }
    
    var googleMapsSmall: String{
        get {
            return _googleMapsSmall
        }
    }
    
    var googleMapsMedium: String{
        get {
            return _googleMapsMedium
        }
    }
    
    init(locationName: String, address1: String, address2: String, address3: String, city: String, state: String, postalCode: String, locationID: Int, googleMapsSmall: String, googleMapsMedium: String, hoursStart: String, hoursEnd: String, daysOpen: String){
        _LocationID = locationID
        _locationName = locationName
        _address1 = address1
        _address2 = address2
        _address3 = address3
        _city = city
        _state = state
        _postalCode = postalCode
        _hoursStart = hoursStart
        _hoursEnd = hoursEnd
        _daysOpen = daysOpen
        _googleMapsSmall = googleMapsSmall
        _googleMapsMedium = googleMapsMedium
    }
}
