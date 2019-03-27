//
//  NotificationController.swift
//  TravelAPIApp WatchKit Extension
//
//  Created by Abita Shiney on 2019-03-15.
//  Copyright © 2019 Abita Shiney. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class NotificationController: WKUserNotificationInterfaceController {

    //MARK: OUTLETS
    @IBOutlet weak var outputText: WKInterfaceLabel!
    
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
         
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        print("Notification called:::")
        
      //called method
        generateDate()
      
    }
    
    func generateDate(){
        print("Function is called")
        
        let hour1 = 8
        print("Hour: \(hour1)")
        let minutes1 = 40
        
        let hour2 = 7
        print("Hour: \(hour2)")
        let minutes2 = 10
        
        // differences of date and time
        let realHour = hour1 - hour2
        let realMin = minutes1 - minutes2
        
        if(realHour == 2)
        {
            outputText.setText("CHECK IN")
        }
        else if(realHour == 1)
        {
            outputText.setText("GO TO GATE")
        }
        else if (realMin == 30)
        {
            outputText.setText("NOW BOARDING")
        }
        else if(realMin == 0)
        {
            outputText.setText("IN FLIGHT")
        }
        else
        {
             outputText.setText("NO UPCOMING TRIPS")
        }

    }
   
}
