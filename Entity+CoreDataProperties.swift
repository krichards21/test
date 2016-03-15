//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Kimate Richards on 3/15/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entity {

    @NSManaged var locationName: String?
    @NSManaged var locationId: NSNumber?
    @NSManaged var imageURL: String?

}
