//
//  SWLocation+CoreDataProperties.swift
//  
//
//  Created by Kimate Richards on 3/16/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SWLocation {

    @NSManaged var imageURL: String?
    @NSManaged var locationID: NSNumber?
    @NSManaged var locationName: String?

}
