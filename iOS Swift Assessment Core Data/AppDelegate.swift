//
//  AppDelegate.swift
//  iOS Swift Assessment Core Data
//
//  Created by Flatiron School on 8/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var store = DataStore()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        store.fetchData()
        
        for author in store.authors {
            
            // let authorsBooks = author.books?.allObjects as! [B]
            
            print("******** AUTHOR INFORMATION ********")
            print("NAME: \(author.name)")
            print("BOOKS: \(author.books)")
            
        }

        
        //////////////
        return true // Don't touch this!
        //////////////
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        store.saveContext()
    }

}

