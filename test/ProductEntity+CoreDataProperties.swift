//
//  ProductEntity+CoreDataProperties.swift
//  test
//
//  Created by Kimate Richards on 4/5/16.
//  Copyright © 2016 designmind. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ProductEntity {

    @NSManaged var productDescription: String?
    @NSManaged var productID: NSNumber?
    @NSManaged var productName: String?

}
