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

    var data : [[String: String]] = []
    var dataSub : [[String : String]] = []
    var session : WCSession?
    var interFace : InterfaceController!
    var bookedList : [[String:String]] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        interFace = context as? InterfaceController
        var data :  [[String : String]] = []
        data = interFace.data
       // print(data.count)
        //   bookedList = []
        for game in data{
            print("got a new booked data")
           // if(game["airlines"] == "airlines 1"){
                bookedList.append(game)
          //  print(bookedList)
           // }
          }
        print("-----\(bookedList.count)")
         var index = 0
        if(bookedList.count == 0){
            self.BookedFlightsTabel.setNumberOfRows(1, withRowType: "booked_cell")
            let row = self.BookedFlightsTabel.rowController(at: index) as! BookFlightCellController
            row.airlinesLabel.setText("NO Flights Booked ")
            print("NO Flights Booked")
        }else{
            self.BookedFlightsTabel.setNumberOfRows(bookedList.count, withRowType: "booked_cell")
            for flights in bookedList {

                print(flights)
                print(index)
                let row = self.BookedFlightsTabel.rowController(at: index) as! BookFlightCellController
                
                row.airlinesLabel.setText(flights["airlines"])
                 row.arrivalCity.setText(flights["arrivalCity"])
                 row.deptCity.setText(flights["depatureCity"])
                 row.deptDate.setText(flights["depatureDate"])
                //            print("inside")
//                row.airlineName.setText(flight["airlines"] )
//                row.departCity.setText(flight["depatureCity"] )
//                row.arrivalCity.setText(flight["arrivalCity"] )
//                row.price.setText("$\(flight["price"]!)")
//                let row = self.BookedFlightsTabel.rowController(at: index) as! BookFlightCellController
//                row.airlinesLabel.setText(flights["airlines"] )
//                print("airlines data...........")
                index = index + 1
            }
//
      }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        session = WCSession.default
        session?.delegate = self
        session?.activate()
        
//        let sharedPreferences = UserDefaults.standard
//        var flight = sharedPreferences.string(forKey: "data")
//
//        if (flight == nil) {
//
//            print("No airlines found")
//        }
//        else {
//            print("I found airlines: \(flight!)")
//
//        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //MARK: Stub for session
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
         print("Book message received")
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            print("message receive in booked ticket")
        dataSub = data
        data = message["data"] as! [[String : String]]
        print(data.count)
        interFace.data = data
        bookedList = []
        for game in data{
            print("got a new booked data")
              bookedList.append(game)
            //            if(game["airlines"] == nil){
            //                bookedList.append(game)
            //            }
        }
        var index = 0
        if(bookedList.count == 0){
            self.BookedFlightsTabel.setNumberOfRows(1, withRowType: "booked_cell")
            let row = self.BookedFlightsTabel.rowController(at: index) as! BookFlightCellController
            row.airlinesLabel.setText("NO GAMES ")
            print("no games")
        }else{
            self.BookedFlightsTabel.setNumberOfRows(bookedList.count, withRowType: "booked_cell")
            for game in bookedList {
                
                let row = self.BookedFlightsTabel.rowController(at: index) as! BookFlightCellController
               // row.airlinesLabel.setText(game["airlines"] )
                row.airlinesLabel.setText(game["airlines"])
                row.arrivalCity.setText(game["arrivalCity"])
                row.deptCity.setText(game["depatureCity"])
                row.deptDate.setText(game["depatureDate"])
                print("airlines data...........")
                index = index + 1
            }
            
        }
        
    }
    }


