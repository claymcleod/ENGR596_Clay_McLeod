//
//  ViewController.swift
//  RecipeBook
//
//  Created by Clay McLeod on 1/28/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit

class MyTableViewController : UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var recipies : NSArray = ["Eggs Benedict", "Mushroom Risotto", "Full Breakfast", "Hamburger", "Ham and Egg Sandwich", "Creme Brelee", "White Chocolate Donut", "Starbucks Coffee", "Vegetable Curry", "Instant Noodle with Egg", "Noodle with BBQ Pork", "Japanese Noodle with Pork", "Green Tea", "Thai Shrimp Cake", "Angry Birds Cake", "Ham and Cheese Panini"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipies.count;
    }
    
    var cell : UITableViewCell?
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        cell.textLabel?.text = recipies.objectAtIndex(indexPath.row) as? String;
        //cell.detailTextLabel?.text = "Subtitle #\(indexPath.row)"
        
        return cell;
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}

