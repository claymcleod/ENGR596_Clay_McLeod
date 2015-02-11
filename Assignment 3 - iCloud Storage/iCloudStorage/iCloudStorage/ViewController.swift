//
//  ViewController.swift
//  iCloudStorage
//
//  Created by Clay McLeod on 2/11/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    var publicDatabase : CKDatabase?
    var privateDatabase : CKDatabase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        privateDatabase = CKContainer.defaultContainer().privateCloudDatabase
        
        let partyRecord : CKRecord = CKRecord(recordType: "Party")
        partyRecord.setObject("UMiOS Bar Crawl", forKey: "Description")
        partyRecord.setObject(NSDate(timeIntervalSinceNow: 24 * 3600), forKey: "Date")
        
        /*
            Types able to be stored in iCloud:
        
                (1) NSString
                (2) NSNumber
                (3) NSData
                (4) NSDate
                (5) NSArray
                (6) CLLocation
                (7) CKAsset
                (8) CKReference
        */
        
        let barRecord : CKRecord = CKRecord(recordType: "Bar")
        barRecord.setObject("Corner Bar", forKey: "Name")
        
        let partyReference : CKReference = CKReference(record: partyRecord, action: .None)
        barRecord.setObject(partyReference, forKey: "Party")

        /*

        // Saving records to database
        
        publicDatabase?.saveRecord(partyRecord, completionHandler: { (record, error) -> Void in
            if (error != nil) {
                println("Error: \(error.localizedDescription)")
            } else {
                println("Success for partyRecord!")
            }
        })
        
        publicDatabase?.saveRecord(barRecord, completionHandler: { (record, error) -> Void in
            if (error != nil) {
                println("Error: \(error.localizedDescription)")
            } else {
                println("Success for barRecord!")
            }
        })

        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

