//
//  FASettingsViewController.swift
//  FlickrApplication
//
//  Created by Clay McLeod on 2/5/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit

class FASettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var resultsPerSearchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsPerSearchLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return FLICKR_APPLICATION_POSSIBLE_RESULTS_PER_PAGE_OPTIONS.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return FLICKR_APPLICATION_POSSIBLE_RESULTS_PER_PAGE_OPTIONS[row].description
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        FLICKR_APPLICATION_CURRENT_RESULTS_PER_PAGE = FLICKR_APPLICATION_POSSIBLE_RESULTS_PER_PAGE_OPTIONS[row]
    }
}
