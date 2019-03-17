//
//  BookFlightInterfaceInterfaceController.swift
//  TravelAPIApp WatchKit Extension
//
//  Created by Charmi Mehta on 2019-03-16.
//  Copyright © 2019 Abita Shiney. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class BookFlightInterfaceInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet weak var BookedFlightsTabel: WKInterfaceTable!
    var data: [[String : String]] = []

     var session : WCSession?
    
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
        
        let sharedPreferences = UserDefaults.standard
        var flight = sharedPreferences.string(forKey: "data")
        
        if (flight == nil) {

            print("No airlines found")
        }
        else {
            print("I found airlines: \(flight!)")
            
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //MARK: Stub for session
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            print("message receive in booked ticket")
        
    }

}
