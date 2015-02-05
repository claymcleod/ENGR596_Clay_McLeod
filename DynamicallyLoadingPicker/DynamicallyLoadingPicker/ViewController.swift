//
//  ViewController.swift
//  DynamicallyLoadingPicker
//
//  Created by Clay McLeod on 1/13/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!
    
    var missionsDict : NSDictionary!
    var missionsTopLevelArray: NSArray!
    var missionsLevelArray:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("missions", ofType: "plist") {
            missionsDict = NSDictionary(contentsOfFile: path)
            missionsTopLevelArray = missionsDict.allKeys
            missionsLevelArray = missionsDict.objectForKey(missionsTopLevelArray[0]) as NSArray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2;
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return missionsTopLevelArray.count;
        } else {
            return missionsLevelArray.count;
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (component == 0) {
            return missionsTopLevelArray[row] as NSString
        } else {
            return missionsLevelArray[row] as NSString
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            missionsLevelArray = missionsDict.objectForKey(missionsTopLevelArray[row]) as NSArray
            pickerView.reloadComponent(1)
        }
    }
}

