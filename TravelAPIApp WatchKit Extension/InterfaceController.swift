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
       //  print("message receive")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
      //  print("message receive......\(message)")
        
        var index = 0
        
        data = message["data"] as! [[String : String]]
        print("Rows:\(data.count)")
        
        self.FlightTable.setNumberOfRows(data.count, withRowType: "flight_cell")
        for flight in data {
            
           // print("Flight: \(flight)")
           
            let row = self.FlightTable.rowController(at: index) as! InterfaceCellController
            
//            print("inside")
            row.airlineName.setText(flight["airlines"] )
            row.departCity.setText(flight["depatureCity"] )
            row.arrivalCity.setText(flight["arrivalCity"] )
            row.price.setText("$\(flight["price"]!)")
        
//            let airlines = flight["airlines"]
//            let departCity = flight["depatureCity"]
//            let arrivalCity = flight["arrivalCity"]
//            let departureDate = flight["depatureDate"]
//
//            let sharedPreferences = UserDefaults.standard
//            sharedPreferences.set(airlines, forKey: "airlines")
//            sharedPreferences.set(departCity, forKey: "depatureCity")
//            sharedPreferences.set(arrivalCity, forKey: "arrivalCity")
//            sharedPreferences.set(departureDate, forKey: "depatureDate")
            
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
    
//    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
//        pushController(withName: "BookFlightInterfaceController",
//                               context: data[rowIndex-1])
//    }
    
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
