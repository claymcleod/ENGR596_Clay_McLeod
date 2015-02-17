/*

  CSDatabaseUtility.swift
  iCloudStorage

  Created by Clay McLeod on 2/11/15.
  Copyright (c) 2015 Clay McLeod. All rights reserved.

  -----------------------------------------------------

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

import Foundation
import CloudKit

let _databaseUtility : CSDatabaseUtility = { CSDatabaseUtility() }()

class CSDatabaseUtility: NSObject {
    
    class func sharedDatabaseUtility() -> CSDatabaseUtility {
        return _databaseUtility
    }
    
    var publicDatabase : CKDatabase?
    var privateDatabase : CKDatabase?
    
    private override init () {
        publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        privateDatabase = CKContainer.defaultContainer().privateCloudDatabase
    }
    
    func saveSampleItemsToPublicDatabase() {
        // Saving records to database
        
        let partyRecord : CKRecord = CKRecord(recordType: "Party")
        partyRecord.setObject("UMiOS Bar Crawl", forKey: "Description")
        partyRecord.setObject(NSDate(timeIntervalSinceNow: 24 * 3600), forKey: "Date")
        
        let barRecord : CKRecord = CKRecord(recordType: "Bar")
        barRecord.setObject("Corner Bar", forKey: "Name")
        
        let partyReference : CKReference = CKReference(record: partyRecord, action: .None)
        barRecord.setObject(partyReference, forKey: "Party")
        
        publicDatabase?.saveRecord(partyRecord, completionHandler: { (record, error) -> Void in
            if (error != nil) {
                println("[DatabaseUtility] Error: \(error.localizedDescription)")
            } else {
                println("[DatabaseUtility] Saved sample record: partyRecord!")
            }
        })
        
        
        publicDatabase?.saveRecord(barRecord, completionHandler: { (record, error) -> Void in
            if (error != nil) {
                println("[DatabaseUtility] Error: \(error.localizedDescription)")
            } else {
                println("[DatabaseUtility] Saved sample record: barRecord!")
            }
        })
    }
    
    func queryPublicDatabaseForName(recordType: NSString, name: NSString) {
        
        // Predicate formatting guide: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Predicates/AdditionalChapters/Introduction.html
        
        let predicate = NSPredicate(format: "Name = %@", name)
        let query = CKQuery(recordType: recordType as! String, predicate: predicate)
        
        publicDatabase?.performQuery(query, inZoneWithID: nil, completionHandler: { (results, error) -> Void in
            println("[DatabaseUtility] Found \(results.count) results.")
            println("  |\n   --> Predicate: \(predicate.description)\n")
        })
    }
    
    func createSubscriptionForParty() {
        
        // Create a predicate that looks for parties in the future.
        
        let predicate : NSPredicate = NSPredicate(format: "TRUEPREDICATE");
        var subscription : CKSubscription = CKSubscription(recordType: "Party", predicate: predicate, options: CKSubscriptionOptions.FiresOnRecordCreation);
        var notificationInfo : CKNotificationInfo = CKNotificationInfo();
        notificationInfo.alertLocalizationKey = "creationAlertBodyKey"
        notificationInfo.shouldBadge = false
        notificationInfo.desiredKeys = ["Description"]
        notificationInfo.alertActionLocalizationKey = "creationAlertActionKey"
        
        subscription.notificationInfo = notificationInfo;
        
        publicDatabase?.saveSubscription(subscription, completionHandler: { (subscription, error) -> Void in
            
            if (error != nil) {
                println("[DatabaseUtility] Could not save subscription!");
            } else {
                println("[DatabaseUtility] Successfully saved subscription!");
            }
        });
    }
}