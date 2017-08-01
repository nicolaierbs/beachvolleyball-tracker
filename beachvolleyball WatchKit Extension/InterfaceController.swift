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
            motionManager.deviceMotionUpdateInterval = 1
            motionManager.startDeviceMotionUpdates(to: queue) {
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                if let gravity = data?.gravity {
                    let rotation = atan2(gravity.x, gravity.y) - Double.pi
                    print (rotation)
                }
            }
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func addActionLowerReception() {
        print("Add action: lower reception")
        detectedAction.setText("Untere Annahme")
    }
    @IBAction func addActionUpperReception() {
        print("Add action: upper reception")
        detectedAction.setText("Obere Annahme")
    }
    
            }
