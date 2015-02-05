//
//  MainViewController.swift
//  SimpleTipCalculator
//
//  Created by Clay McLeod on 1/27/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipDueLabel: UILabel!
    @IBOutlet weak var tipStepper: UIStepper!
    @IBOutlet weak var totalDueLabel: UILabel!
    @IBOutlet weak var totalTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         *  Dismiss keyboard when user taps on background
         */
        
        var tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("resignKeyboard"));
        self.view.addGestureRecognizer(tapGestureRecognizer);
        
        /*
         *  Programmatically change the frame height of the text field
         */
        
        var modifiedFrame = totalTextField.frame;
        modifiedFrame.size.height = 70;
        totalTextField.frame = modifiedFrame;
        
        /*
         *  Add the 'Done' button to the toolbar above the keypad.
         */
        
        var toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: 44.0));
        
        toolbar.tintColor = UIColor.whiteColor();
        toolbar.barStyle = UIBarStyle.Black;
        toolbar.translucent = true;
        
        let barButtonItems = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action:nil),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("resignKeyboard"))
        ]
    
        toolbar.setItems(barButtonItems, animated: false);
        
        totalTextField.inputAccessoryView = toolbar;
        
        /*
        *  Play Mario Sound
        */
        
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mario", ofType: "wav")!)
        println(alertSound)
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        var audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func performTipCalculation() {
        
        let tipPercentage : Int = Int(tipStepper.value);
        let total : Double = (totalTextField.text as NSString).doubleValue;
        let tipAmount : Double = (Double(tipPercentage) / 100) * total;
        let totalDue : Double = total + tipAmount;
        
        if totalTextField.text.isEmpty {
            
            tipLabel.text = "Tip Percentage: \(tipPercentage)%";
            tipDueLabel.text = "Please input a valid total!";
            totalDueLabel.text = "";
            
        } else {
        
            var properlyFormattedTipDue : String = String(format: "%0.2f",tipAmount);
            var properlyFormattedTotalDue : String = String(format: "%0.2f",totalDue);
        
            tipLabel.text = "Tip Percentage: \(tipPercentage)%";
            tipDueLabel.text = "Tip Due: $\(properlyFormattedTipDue)";
            totalDueLabel.text = "Total Due: $\(properlyFormattedTotalDue)";
            
        }
    }
    
    func resignKeyboard() {
        
        /*
         *  Resigns the keyboard from view
         */
        
        totalTextField.resignFirstResponder();
    }
    
    
    @IBAction func totalValueFinishedEditting(sender: AnyObject) {
        resignKeyboard();
        performTipCalculation();
    }
    
    @IBAction func tipValueChanged(sender: AnyObject) {
        resignKeyboard();
        performTipCalculation();
    }
}
