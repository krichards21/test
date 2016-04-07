//
//  InventoryEntity+CoreDataProperties.swift
//  test
//
//  Created by Kimate Richards on 4/7/16.
//  Copyright © 2016 designmind. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension InventoryEntity {

    @NSManaged var cbf: NSNumber?
    @NSManaged var classification: String?
    @NSManaged var cluster: NSNumber?
    @NSManaged var coldbox: NSNumber?
    @NSManaged var coldboxBrands: NSNumber?
    @NSManaged var coverage: NSNumber?
    @NSManaged var current: NSNumber?
    @NSManaged var dateCollected: String?
    @NSManaged var display: NSNumber?
    @NSManaged var displayBrands: NSNumber?
    @NSManaged var largest: NSNumber?
    @NSManaged var locationID: NSNumber?
    @NSManaged var pod: NSNumber?
    @NSManaged var productID: NSNumber?
    @NSManaged var scematicFacings: NSNumber?
    @NSManaged var totalCases: NSNumber?
    @NSManaged var inventoryID: NSNumber?

}
