//
//  ViewController.swift
//  TravelAPIApp
//
//  Created by Abita Shiney on 2019-03-15.
//  Copyright © 2019 Abita Shiney. All rights reserved. hjghgchsg hjhhj
//

import UIKit
import Alamofire
import SwiftyJSON
import WatchConnectivity

class ViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate, WCSessionDelegate{

    @IBOutlet weak var toTextField: UITextField!
    
    @IBOutlet weak var arrivalTextField: UITextField!
    
    var toData:[String] = []
     var arrivalData:[String] = []
    var pickerView = UIPickerView()
    var currentTextField = UITextField()
    var jsonResponse = JSON()
    var cityList = JSON()
    //var resultData = JSON()
    var wcSession : WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
        
        let URL = "https://5c8d0bf335643b001493895a.mockapi.io/api/v1/Flight/"
        
        Alamofire.request(URL).responseJSON {
            // 1. store the data from the internet in the
            // response variable
            response in
            
            // 2. get the data out of the variable
            guard let apiData = response.result.value
            else {
                print("Error getting data from the URL")
                return
            }
            
            // OUTPUT the json response to the terminal
            print("=================")
           // print(apiData)
            // GET something out of the JSON response
            self.jsonResponse = JSON(apiData)
            self.cityList = self.jsonResponse["items"]
            
            for (key, value1) in self.cityList{

               // print(value1["depatureCity"])
                self.toData.append(value1["depatureCity"].string!)
                self.arrivalData.append(value1["arrivalCity"].string!)
                
            }
        }
    }
    //MARK: Picker view Stubs
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == toTextField{
            return toData.count
        }
        else if currentTextField == arrivalTextField{
            return arrivalData.count
        }
        else{
        return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //return toTextField.text = data[row]
        if currentTextField == toTextField{
           toTextField.text = toData[row]
            self.view.endEditing(true)
        }
        else if currentTextField == arrivalTextField{
            arrivalTextField.text = arrivalData[row]
            self.view.endEditing(true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == toTextField{
            return toData[row]
        }
        else if currentTextField == arrivalTextField{
            return arrivalData[row]
        }
        else{
            return ""
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField
        
        if currentTextField == toTextField{
            currentTextField.inputView = pickerView
        }
       else if currentTextField == arrivalTextField{
            currentTextField.inputView = pickerView
        }
    }
    
    //MARK: WCsession or watch connectivity stubs
    
    @IBAction func serachBtn(_ sender: Any) {
        print("button clicked")
        
        var toCity = toTextField.text
        var arrivalCity = arrivalTextField.text
        
        for (key, value1) in self.cityList{
            
            var dataSend : [[String : String]] = []
            var tempArray : [String : String] = [:]
            
            if(value1["depatureCity"].string == toCity && value1["arrivalCity"].string == arrivalCity){
                
                for (key2, value2) in value1{
                 
                    tempArray[key2] = value2.string!
                    
                }
                dataSend.append(tempArray)
                
                wcSession.sendMessage(["data": dataSend], replyHandler: nil) { (err) in
                    print(err.localizedDescription)
                }
            }
        }
        
//        func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//            let receivedGlobal = applicationContext["my_global"] as?
//        }
        
        
//        wcSession.sendMessage(resultData, replyHandler: nil) { (err) in
//            print(err.localizedDescription)
//        }
//
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
            
    }
}

