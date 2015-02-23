//
//  ViewController.swift
//  DynamicKitExample
//
//  Created by Clay McLeod on 2/19/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    lazy var _animator : UIDynamicAnimator! = {
        [unowned self] in
        
        return UIDynamicAnimator(referenceView: self.view)
    }()
    
    lazy var _gravity : UIGravityBehavior! = {
        return UIGravityBehavior()
    }()

    lazy var _collision  : UICollisionBehavior! = {
       var collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        return collision
    }()
    
    lazy var _motionManager : CMMotionManager = {
        return CMMotionManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tgr : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "touchDidOccur:")
        
        self.view.addGestureRecognizer(tgr)
        
        _animator.addBehavior(_gravity)
        _animator.addBehavior(_collision)
        _motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue(), withHandler: { (deviceMotion, error) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self._gravity.gravityDirection = CGVector(dx: deviceMotion.gravity.x, dy: -deviceMotion.gravity.y)
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func addNewShapeView() {
        
        var randomSize = 30 + Int(arc4random_uniform(20))
        var randomX = Int(arc4random_uniform(UInt32(self.view.frame.size.width)))
        var randomY = Int(arc4random_uniform(UInt32(self.view.frame.size.height / 2)))
        var shape : UIView = UIView(frame: CGRect(x: randomX, y: randomY, width: randomSize, height: randomSize))
        
        let randomShape = Int(arc4random_uniform(2))
        if (randomShape == 0) {
            shape.layer.cornerRadius = shape.frame.size.height / 2.0
            shape.layer.masksToBounds = true
        }
        
        let randomColor = Int(arc4random_uniform(6))
        switch (randomColor) {
        case 0: shape.backgroundColor = UIColor.redColor()
                break
        case 1: shape.backgroundColor = UIColor.yellowColor()
                break
        case 2: shape.backgroundColor = UIColor.orangeColor()
                break
        case 3: shape.backgroundColor = UIColor.greenColor()
            break
        case 4: shape.backgroundColor = UIColor.purpleColor()
            break
        case 5: shape.backgroundColor = UIColor.blueColor()
            break
        default: shape.backgroundColor = UIColor.blueColor()
        }
        
        self.view.addSubview(shape)
        _gravity.addItem(shape)
        _collision.addItem(shape)
    }
    
    func touchDidOccur(recognizer: UITapGestureRecognizer){
        addNewShapeView()
    }
}

