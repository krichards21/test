//
//  SWLocation+CoreDataProperties.swift
//  test
//
//  Created by Kimate Richards on 4/4/16.
//  Copyright © 2016 designmind. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

class SWLocation : NSManagedObject {

    @NSManaged var address1: String?
    @NSManaged var address2: String?
    @NSManaged var address3: String?
    @NSManaged var city: String?
    @NSManaged var county: String?
    @NSManaged var googleMapMedium: String?
    @NSManaged var googleMapSmall: String?
    @NSManaged var imageURL: String?
    @NSManaged var locationID: NSNumber?
    @NSManaged var locationName: String?
    @NSManaged var operatingDays: String?
    @NSManaged var hoursEnd: String?
    @NSManaged var hoursStart: String?
    @NSManaged var postalCode: String?
    @NSManaged var state: String?
    @NSManaged var url: String?

}
