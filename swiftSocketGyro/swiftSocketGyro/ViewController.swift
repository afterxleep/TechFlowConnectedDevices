//
//  ViewController.swift
//  swiftSocketGyro
//
//  Created by Daniel Bernal on 5/7/18.
//  Copyright © 2018 Daniel Bernal. All rights reserved.
//

import UIKit

struct Message: Codable {
    let name: String?
    let pitch: Double?
    let roll: Double?
}

class ViewController: UIViewController, MotionAware, SocketDelegate {
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var pitchTxt: UITextField!
    @IBOutlet weak var rollTxt: UITextField!
    
    lazy var motionManager = {
        return MotionManager(withInterval: Config.gyroUpdateInterval, andDelegate: self)
    }()
    
    lazy var socket = {
        return SocketManager(withUrl: Config.serverURL, andDelegate: self)
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
        
        // Start & Stop monitoring and update the UI
        if(!motionManager.isActive()) {
            actionBtn.setTitle("Stop", for: .normal)
            socket.connect()
            motionManager.startMotionUpdates()
            
            
        }
        else {
            actionBtn.setTitle("Start", for: .normal)
            motionManager.stopMotionUpdates()
            socket.disconnect()
        }
    }
    
    
    // MARK: MotionAware Delegate Methods
    func onNewMotionData(attitude: (pitch: Double, roll: Double, yaw: Double)) {        
        pitchTxt.text =  attitude.pitch.description
        rollTxt.text = attitude.roll.description
        
        if(socket.isConnected()) {
            let message = Message(name: self.nameTxt.text,
                                  pitch: attitude.pitch,
                                  roll: attitude.roll)
            let jsonEncoder = JSONEncoder()
            let jsonData = try! jsonEncoder.encode(message)
            socket.writeMessage(message: String(data: jsonData, encoding: .utf8)!)
        }
    }
    
    // MARK: Socket Delegate Methods
    func onSocketConnected() {
        print("Socket Connected Successfully")
    }
    
    func onSocketDisconnected(error: Error?) {
        guard let e = error else {
            print("Socket disconnected without error")
            return
        }
        print("Socket disconnected: Error \(e)" )
    }
    
    func onSocketMessageReceived(message: String) {
        print(message)
    }
}

