//
//  ViewController.swift
//  swiftSocketGyro
//
//  Created by Daniel Bernal on 5/7/18.
//  Copyright © 2018 Daniel Bernal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MotionAware {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var pitchTxt: UITextField!
    @IBOutlet weak var rollTxt: UITextField!
    
    lazy var motionManager = {
        return MotionManager(withInterval: 10.0, andDelegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Trigger motion action button
    @IBAction func triggerMotion() {
        
        // Check for motionManager availability
        if(!motionManager.isAvailable()) {
            print("Device motion sensors are not available")
            return
        }
        
        // Start & Stop monitorion
        if(!motionManager.isActive()) {
            actionBtn.setTitle("Stop", for: .normal)
        }
        else {
            actionBtn.setTitle("Start", for: .normal)
            motionManager.stopMotionUpdates()
        }
    }
    
    // MARK - MotionAwareDelegate
    func onNewMotionData(attitude: (pitch: Double, roll: Double, yaw: Double)) {        
        pitchTxt.text =  attitude.pitch.description
        rollTxt.text = attitude.roll.description
    }


}

