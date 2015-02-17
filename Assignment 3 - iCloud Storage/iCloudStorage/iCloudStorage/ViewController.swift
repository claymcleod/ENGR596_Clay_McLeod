/*

  ViewController.swift
  iCloudStorage

  Created by Clay McLeod on 2/11/15.
  Copyright (c) 2015 Clay McLeod. All rights reserved.

*/

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseUtility : CSDatabaseUtility = CSDatabaseUtility.sharedDatabaseUtility()
        
        /*
        
        // Sample item creation
        
        databaseUtility.saveSampleItemsToPublicDatabase()
        
        */
        
        /*

        // Querying the database
        
        databaseUtility.queryPublicDatabaseForName("Bar", name: "Corner Bar")
        databaseUtility.queryPublicDatabaseForName("Bar", name: "Funkys")

        */
        
        /*
        
        // Create part subscription
        
        databaseUtility.createSubscriptionForParty();
        
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

