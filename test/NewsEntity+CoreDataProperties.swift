//
//  NewsEntity+CoreDataProperties.swift
//  
//
//  Created by Kimate Richards on 5/31/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NewsEntity {

    @NSManaged var alertDescription: String?
    @NSManaged var alertType: NSNumber?
    @NSManaged var dateNews: NSDate?
    @NSManaged var alertID: NSNumber?

}
