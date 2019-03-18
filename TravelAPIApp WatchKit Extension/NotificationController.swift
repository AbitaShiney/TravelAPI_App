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
        
      
    }
//    override func didReceive(_ localNotification: UILocalNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
//
//        if let aps = localNotification["aps"] as? NSDictionary
//        {
//
//        }
//
//    }
    
    override func didReceiveRemoteNotification(_ remoteNotification: [AnyHashable : Any], withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        
        let date1 = Date()
        
        let calendar1 = Calendar.current
        
        let day1 = calendar1.component(.day, from: date1)
        
        let year1 = calendar1.component(.year, from: date1)
        
        let month1 = calendar1.component(.month, from: date1)
        
        let hour1 = calendar1.component(.hour, from: date1)
        print("Hour: \(hour1)")
        let minutes1 = calendar1.component(.minute, from: date1)
        if let aps = remoteNotification["aps"] as? NSDictionary {
            if let title = aps["title"] as? String {
                outputText.setText(title)
            }
        }
        if let hour = remoteNotification["hour"] as? NSDictionary {
            if let title = hour["title"] as? String {
                outputText.setText(title)
            }
        }
        completionHandler(WKUserNotificationInterfaceType.custom)
    }
    
   
}
