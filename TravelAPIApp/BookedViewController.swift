//
//  BookedFlightsViewController.swift
//  TravelAPIApp
//
//  Created by Charmi Mehta on 2019-03-17.
//  Copyright © 2019 Abita Shiney. All rights reserved.
//

import UIKit
import WatchConnectivity

class BookedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WCSessionDelegate {
    
    
    
    @IBOutlet weak var demoLable: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var session: WCSession!
    var dataReceived : [String : Any]!
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Table view delegates
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
        
        session = WCSession.default
        session.delegate = self
        session.activate()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Table view stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.dataReceived.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = self.tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        cell.toCity?.text = dataReceived!["arrivalCity"] as! String
        cell.fromCity?.text = dataReceived!["depatureCity"] as! String
        
        return cell
    }
    
    //MARK: Session stubs
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
           // self.outputLabel.text = "Message : \(message)"
            self.dataReceived = message
        }
    }
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        self.demoLable.text = message["demo"]! as? String
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
