//
//  SWLocation.swift
//  test
//
//  Created by Kimate Richards on 3/11/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

    class SWLocation: NSManagedObject {
        
    @NSManaged var locationID: Int
    @NSManaged var locationName: String!
    @NSManaged var address1: String!
    @NSManaged var address2: String!
    @NSManaged var address3: String!
    @NSManaged var city: String!
    @NSManaged var state: String!
    @NSManaged var postalCode: String!
    @NSManaged var hoursStart: String!
    @NSManaged var hoursEnd: String!
    @NSManaged var daysOpen: String!
    @NSManaged var googleMapsSmall: String!
    @NSManaged var googleMapsMedium: String!
    @NSManaged var imageURL: String!
        
    
}

