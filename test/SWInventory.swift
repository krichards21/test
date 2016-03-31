//
//  SWInventory.swift
//  test
//
//  Created by Kimate Richards on 3/24/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import Foundation
import CoreData

class SWInventory: NSManagedObject {
    
    @NSManaged var productID: Int
    @NSManaged var createDate: NSDate!
    @NSManaged var classification: String!
    @NSManaged var userID: Int
    @NSManaged var cluster: Int
    @NSManaged var coldCase: Bool
    @NSManaged var displayCase: Bool
    @NSManaged var coverage: Int
    @NSManaged var display: Int
    @NSManaged var largest: Int
    @NSManaged var current: Int
    @NSManaged var totalCases: Int
    @NSManaged var schematicFacings: Int
    @NSManaged var coldBox: Int
    @NSManaged var pod: Int
    @NSManaged var cbf: Int
    
    
    func downloadInventory(completed: DownloadComplete){
        
    }
}