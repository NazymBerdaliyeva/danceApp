//
//  SognIn2ViewController.swift
//  DanceApp
//
//  Created by mac on 27.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class SignIn2ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var rost = [String]()
    var ves = [String]()
    var selectedTextField : Int = 0
    var countrows : Int = 0
    var tancy = ["Танго", "Сальса", "Джайв", "Бальный танец самба", "Ча-ча-ча", "Венский вальс", "Медленный вальс", "Бачата", "Аргентинское танго", "Медленный фокстрот", "Быстрый фокстрот", "Румба", "Фламенко"]
    @IBOutlet weak var rostTextField: UITextField!
    @IBOutlet weak var vidTanca: UITextField!
    @IBOutlet weak var vesTextField: UITextField!
    
    @IBOutlet weak var dropDownList: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dropDownList.alpha = 0
        for i in 0 ... 80 {
            rost.append("\(i+120) см")
        }
        for i in 0 ... 80 {
            
            ves.append("\(i+30) кг")
        }
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if let height = rostTextField.text, let weight = vesTextField.text,
            let type = vidTanca.text {
            guard let currentUser = Auth.auth().currentUser else { return }
            let userData = ["height": height,
                            "weight": weight,
                            "type": type]
        
           Database.database().reference().root.child("users").child(currentUser.uid).updateChildValues(userData)
      
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (selectedTextField == 0) {
            
            return rost.count
            
        } else if (selectedTextField == 1) {
            
            return ves.count
        } else if(selectedTextField == 2) {
            return tancy.count
        }
        
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (selectedTextField == 0) {
            
            return rost[row]
            
        } else if (selectedTextField == 1) {
            
            return ves[row]
        } else if(selectedTextField == 2) {
            return tancy[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if rostTextField.isFirstResponder{
            let itemselected = rost[row]
            rostTextField.text = String(itemselected)
        }else if vesTextField.isFirstResponder{
            let itemselected = ves[row]
            vesTextField.text = String(itemselected)
        }else if vidTanca.isFirstResponder{
            let itemselected = tancy[row]
            vidTanca.text = itemselected
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField.tag
        if (textField == self.rostTextField){
            self.dropDownList.alpha = 1
        }
        else if(textField == self.vesTextField){
            self.dropDownList.alpha = 1
        }
        else if(textField == self.vidTanca){
            self.dropDownList.alpha = 1
        }
        dropDownList.reloadAllComponents()
        
    }
    
    
}
