//
//  ViewController.swift
//  MultipleAudioStreams
//
//  Created by Clay McLeod on 2/9/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var recorder      : AVAudioRecorder? = nil
    var soundFilePath : NSString? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var error: NSError?
        var session: AVAudioSession = AVAudioSession.sharedInstance()
        
        session.requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
                session.setActive(true, error: &error)
                
                var recordingSettings : NSMutableDictionary = NSMutableDictionary()
                
                recordingSettings.setValue(kAudioFormatLinearPCM,   forKey: AVFormatIDKey)
                recordingSettings.setValue(44100.0,                 forKey: AVSampleRateKey)
                recordingSettings.setValue(2,                       forKey: AVNumberOfChannelsKey)
                recordingSettings.setValue(16,                      forKey: AVLinearPCMBitDepthKey)
                recordingSettings.setValue(false,                   forKey: AVLinearPCMIsBigEndianKey)
                recordingSettings.setValue(false,                   forKey: AVLinearPCMIsFloatKey)
                
                var searchPaths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                self.soundFilePath = (searchPaths.lastObject as NSString).stringByAppendingPathComponent("sound.caf")
                var soundFileURL : NSURL = NSURL(fileURLWithPath: self.soundFilePath!)!
                
                self.recorder = AVAudioRecorder(URL: soundFileURL, settings: recordingSettings, error: &error)
                self.recorder!.delegate = self
                self.recorder!.prepareToRecord()
                self.recorder!.meteringEnabled = true
                
            } else{
                println("not granted")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func recordPressed(sender: AnyObject) {
        recorder!.recordForDuration(3)
    }
    
    var player : AVAudioPlayer?
    
    @IBAction func playPressed(sender: AnyObject) {
        
        var error: NSError?
        //var soundFileURL: NSURL = NSBundle.mainBundle().URLForResource("begin_record", withExtension: "mp3")!
        var soundFileURL : NSURL = NSURL(fileURLWithPath: self.soundFilePath!)!
        player = AVAudioPlayer(contentsOfURL: soundFileURL, error: &error)
        if (error != nil) {
            println("Error!")
        } else {
            player?.prepareToPlay()
            println(player?.play())
        }
        
    }
    
    @IBAction func deletePressed(sender: AnyObject) {
        var error: NSError?
        
        var fileExists : Bool = NSFileManager.defaultManager().fileExistsAtPath(self.soundFilePath!)
        
        if (fileExists) {
            println("Attempting to remove file!")
            NSFileManager.defaultManager().removeItemAtPath(self.soundFilePath!, error: &error)
        } else {
            println("File does not exist!")
        }
    }
}

