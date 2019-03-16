//
//  InterfaceController.swift
//  TravelAPIApp WatchKit Extension
//
//  Created by Abita Shiney on 2019-03-15.
//  Copyright © 2019 Abita Shiney. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
         print("message receive")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            print("message receive......\(message)")
    }
    
    @IBOutlet weak var FlightTable: WKInterfaceTable!
     var session : WCSession?
    
    @IBAction func BookFlightButton() {
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        session = WCSession.default
        session?.delegate = self
        session?.activate()
        self.FlightTable.setNumberOfRows(1, withRowType: "flight_cell")
      
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
