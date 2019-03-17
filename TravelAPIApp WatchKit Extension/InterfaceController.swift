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
    
    @IBOutlet weak var FlightTable: WKInterfaceTable!
    var session : WCSession?
    var data: [[String : String]] = []
  
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        var index = 0
        
        data = message["data"] as! [[String : String]]
        print("Rows:\(data.count)")
        
        self.FlightTable.setNumberOfRows(data.count, withRowType: "flight_cell")
        for flight in data {
            
            // print("Flight: \(flight)")
            let row = self.FlightTable.rowController(at: index) as! InterfaceCellController
            
            row.airlineName.setText(flight["airlines"] )
            row.departCity.setText(flight["depatureCity"] )
            row.arrivalCity.setText(flight["arrivalCity"] )
            row.price.setText("$\(flight["price"]!)")
            
            index = index + 1
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
       // let flightData = data[rowIndex]
        pushController(withName: "bookedInterface", context: self)
    
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        for index in 0..<FlightTable.numberOfRows {
            guard let controller = FlightTable.rowController(at: index) as? BookFlightInterfaceInterfaceController else { continue }
            controller.data = [data[index]]
        }
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
