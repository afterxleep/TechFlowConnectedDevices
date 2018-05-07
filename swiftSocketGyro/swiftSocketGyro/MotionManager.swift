//
//  MotionAware.swift
//  swiftSocketGyro
//
//  Created by Daniel Bernal on 5/7/18.
//  Copyright © 2018 Daniel Bernal. All rights reserved.
//
import Foundation
import CoreMotion

protocol MotionAware {
    func onNewMotionData(attitude: (pitch: Double, roll: Double, yaw: Double))
}

class MotionManager {
    
    var timer: Timer?
    var delegate: MotionAware
    let motion = CMMotionManager()    
    var updateInterval: Double
    
    init(withInterval interval: Double, andDelegate delegate: MotionAware) {
        self.updateInterval = interval
        self.delegate = delegate
    }
    
    private func rad2Deg(r: Double) -> Double {
        return ((180/Double.pi) * r).rounded()
    }
    
    func isActive() -> Bool {
        return motion.isDeviceMotionActive
    }
    
    func isAvailable() -> Bool {
        return motion.isDeviceMotionAvailable
    }
    
    // Start Gyroscope Updates
    func startMotionUpdates() -> Bool {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = updateInterval / 60.0
            motion.startDeviceMotionUpdates()
            
            // Configure a timer to fetch the accelerometer data.
            timer = Timer(fire: Date(), interval: (updateInterval/60.0),
               repeats: true, block: { (timer) in
                // Get the gyro data.
                if let data = self.motion.deviceMotion?.attitude {
                    self.delegate.onNewMotionData(attitude: (
                        pitch: self.rad2Deg(r: data.pitch),
                        roll: self.rad2Deg(r: data.roll),
                        yaw: self.rad2Deg(r: data.yaw)
                    ))
                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
            return true
            
        }
        return false
    }
    
    // Stop Gyroscope updates
    func stopMotionUpdates() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            motion.stopDeviceMotionUpdates()
        }
    }
    
}
