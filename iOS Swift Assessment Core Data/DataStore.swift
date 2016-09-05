//
//  DataStore.swift
//  iOS Swift Assessment Core Data
//
//  Created by Flatiron School on 8/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

struct DataStore {
    
    static let store = DataStore()
    
    var authors = [Author]()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.FlatironSchool.iOS_Swift_Assessment_Core_Data" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("iOS_Swift_Assessment_Core_Data", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    mutating func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    mutating func fetchData() {
        
        // let bookRequest = NSFetchRequest(entityName: "Book")
        let authorRequest = NSFetchRequest(entityName: "Author")
        
        do{
            authors = try managedObjectContext.executeFetchRequest(authorRequest) as! [Author]
        } catch let error as NSError {
            print("error: \(error)")
        }
        
        if authors.count == 0 {
            generateTestData()
        }
        
    }
    
    
    mutating func generateTestData() {
        
        let book1 : Book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        book1.title = "The Swift Programming Language"
        //        book1.author = appleAuthor
        
        let book2 : Book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        book2.title = "Hacking with Swift"
        //        book2.author = author2
        
        let book3 : Book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        book3.title = "Pro Swift"
        //        book3.author = author2
        
        let book4 : Book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        book4.title = "Advanced Swift"
        //        book4.author = author3
        
        let appleAuthor : Author = NSEntityDescription.insertNewObjectForEntityForName("Author", inManagedObjectContext: managedObjectContext) as! Author
        appleAuthor.name = "Apple Inc."
        appleAuthor.books = [book1]
        
        let author2 : Author = NSEntityDescription.insertNewObjectForEntityForName("Author", inManagedObjectContext: managedObjectContext) as! Author
        author2.name = "Paul Hudson"
        author2.books = [book2, book3]
        
        let author3 : Author = NSEntityDescription.insertNewObjectForEntityForName("Author", inManagedObjectContext: managedObjectContext) as! Author
        author3.name = "Chris Eidhof"
        author3.books = [book4]
        
        saveContext()
        fetchData()
    }
}
