//
//  AppDelegate.swift
//  Maps
//
//  Created by Clay McLeod on 3/24/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let googleMapsApiKey = "AIzaSyB9fmRTGjPqJIEbFjhlrFrtrvaCMULval4"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        GMSServices.provideAPIKey(googleMapsApiKey)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

