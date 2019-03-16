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
   //var data : [[String: String]] = []
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
         print("message receive")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            print("message receive......\(message)")
        
       
          var index = 0
        
         data = message["data"] as! [[String : String]]
        print(data.count)
        
         self.FlightTable.setNumberOfRows(data.count, withRowType: "flight_cell")
        for game in data {
            
            print(game)
            
            let row = self.FlightTable.rowController(at: index) as! InterfaceCellController
            // row.countryFlag.setImage(UIImage(named:country.image!))
            print("inside")
            row.airlineName.setText(game["airlines"] )
            // print("--------------\(game["image1"]!)")
           // row.flag2.setImage(UIImage(named: game["image2"]!))
            row.departCity.setText(game["depatureCity"] )
            row.arrivalCity.setText(game["arrivalCity"] )
            row.price.setText(game["price"] )
           // row.btnBook
            index = index + 1
            
        }
        
    }
    
  
    @IBOutlet weak var FlightTable: WKInterfaceTable!
    var session : WCSession?
     var data: [[String : String]] = []
    
    @IBAction func BookFlightButton() {
        print("Button click")
        
         self.pushController(withName: "bookedInterface", context: self)
//        session!.sendMessage(["data" : data], replyHandler: nil) { (err) in
//            print(err.localizedDescription)
//        }
        
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
        
        
      
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
