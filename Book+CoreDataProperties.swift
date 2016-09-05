//
//  Book+CoreDataProperties.swift
//  iOS Swift Assessment Core Data
//
//  Created by Betty Fung on 8/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var title: String?
    @NSManaged var author: Author?

}
