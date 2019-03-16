//
//  ViewController.swift
//  TravelAPIApp
//
//  Created by Abita Shiney on 2019-03-15.
//  Copyright © 2019 Abita Shiney. All rights reserved. hjghgchsg
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate{
  
    

    @IBOutlet weak var toTextField: UITextField!
    
    @IBOutlet weak var arrivalTextField: UITextField!
    
    var data = ["q" ,"d" ,"f"]
    var pickerView = UIPickerView()
    var currentTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            print(apiData)
        }
            
        // Do any additional setup after loading the view, typically from a nib.
       
//        toTextField.delegate = self
//        arrivalTextField.delegate = self
//        toTextField.inputView = pickerView
//        arrivalTextField.inputView = pickerView
       // toolbar()
        
    }

    //MARK: Picker view Stubs
    
   
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == toTextField{
            return data.count
        }
        else if currentTextField == arrivalTextField{
            return data.count
        }
        else{
        return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //return toTextField.text = data[row]
        if currentTextField == toTextField{
           toTextField.text = data[row]
            self.view.endEditing(true)
        }
        else if currentTextField == arrivalTextField{
            arrivalTextField.text = data[row]
            self.view.endEditing(true)
        }
        
        
       
       
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == toTextField{
            return data[row]
        }
        else if currentTextField == arrivalTextField{
            return data[row]
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

    func toolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyBoard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toTextField.inputAccessoryView = toolBar
    }
    @objc func dismissKeyBoard(){
        view.endEditing(true)
        
    }
}

