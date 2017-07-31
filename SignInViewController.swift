//
//  SignInViewController.swift
//  DanceApp
//
//  Created by mac on 27.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genderDropDown.alpha = 0
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var bdayTextField: UITextField!
    @IBOutlet weak var genderDropDown: UIPickerView!
    
    @IBOutlet weak var genderTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func bdayTextFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        genderTextfield.delegate = self
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(SignInViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, let name = nameLabel.text,let bday = bdayTextField.text, let gender = genderTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    let userData = ["name": name,
                                    "birthday": bday,
                                    "gender": gender]
                    let ref = Database.database().reference()
                    ref.child("users").child(user!.uid).setValue(userData)
                    print("success")
                }
                else {
                    print(error?.localizedDescription ?? "AAA")
                    return    
                }
            })
        }
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        bdayTextField.text = dateFormatter.string(from: sender.date)
    }
    
    var gender = ["парень", "девушка"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTextfield.text = gender[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.genderTextfield){
            self.genderDropDown.alpha = 1
        }
        else {
            self.genderDropDown.alpha = 0
        }
    }
}
