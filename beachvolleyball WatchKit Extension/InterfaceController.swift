//
//  InterfaceController.swift
//  beachvolleyball WatchKit Extension
//
//  Created by Erbs on 31.07.17.
//  Copyright © 2017 Nicolai Erbs. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var detectedAction: WKInterfaceLabel!
    
    var motionManager: CMMotionManager!
    
    let updateInterval = 0.02
    
    let rotationThreshold = 10.0
    let userAccelerationTthreshold = 2.0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let queue = OperationQueue()
        
        motionManager = CMMotionManager()
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = updateInterval
            motionManager.startDeviceMotionUpdates(to: queue) {
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                if let userAcceleration = data?.userAcceleration {
                    self?.printStrongMovement(userAcceleration: userAcceleration, rotationRate: data!.rotationRate)                }
            }
        }
    }
    
    private func printStrongMovement(userAcceleration: CMAcceleration, rotationRate: CMRotationRate){
        let totalAcceleration = sqrt(pow(userAcceleration.x, 2)+pow(userAcceleration.y, 2)+pow(userAcceleration.z, 2))
        if(totalAcceleration>userAccelerationTthreshold){
            print("Total: ", totalAcceleration, ", accelerationX: ", userAcceleration.x, ", accelerationY: ", userAcceleration.y, ", accelerationZ: ", userAcceleration.z)
        }
        
        let totalRotation = sqrt(pow(rotationRate.x, 2)+pow(rotationRate.y, 2)+pow(rotationRate.z, 2))
        if(totalRotation>rotationThreshold){
            print("Total: ", totalRotation, ", rotationX: ", rotationRate.x, ", rotationY: ", rotationRate.y, ", rotationZ: ", rotationRate.z)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func addActionLowerReception() {
        addAction(type: "Untere Annahme")
    }
    @IBAction func addActionUpperReception() {
        addAction(type: "Obere Annahme")
    }
    @IBAction func addActionDefense() {
        addAction(type: "Abwehr")
    }
    @IBAction func addActionBlock() {
        addAction(type: "Block")
    }
    @IBAction func addActionBumpSet() {
        addAction(type: "Unteres Zuspiel")
    }
    @IBAction func addActionHandSet() {
        addAction(type: "Oberes Zuspiel")
    }
    @IBAction func addActionSmash() {
        addAction(type: "Smash")
    }
    @IBAction func addActionShot() {
        addAction(type: "Shot")
    }
    
    private func addAction(type: String){
        print("Add action: ", type)
        detectedAction.setText(type)
    }
    
            }
