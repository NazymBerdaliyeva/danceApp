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
import  FirebaseStorage
import SwiftKeychainWrapper

class SignInViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    
    @IBOutlet weak var userImagePicker: UIImageView!
    @IBOutlet weak var completeSignInBtn: UIButton!
    
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genderDropDown.alpha = 0
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.userImagePicker.layer.borderWidth = 1
        self.userImagePicker.layer.borderColor = UIColor.init(red: 0.7137, green: 0.7176, blue: 0.7255, alpha: 0.7).cgColor
        self.navigationController?.navigationBar.topItem?.title = "";
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 0.9608, green: 0.3529, blue: 0.6196, alpha: 0.9)
        
    }
    
    func keychain() {
        guard let currentUser = Auth.auth().currentUser else { return }
        KeychainWrapper.standard.set(currentUser.uid, forKey: "uid")
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            userImagePicker.image = image
            imageSelected = true
        }
        else {
            print("Image wasnt selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func setUpUser(img: String){
        guard let currentUser = Auth.auth().currentUser else { return }
        if let name = nameLabel.text,let bday = bdayTextField.text, let gender = genderTextfield.text{
            let userData = ["name": name,
                            "birthday": bday,
                            "gender": gender,
                            "userImg": img
            ]
            keychain()
            let ref = Database.database().reference()
            ref.child("users").child(currentUser.uid).setValue(userData)
        }
    }
    func uploadImage(){
        if nameLabel.text == nil {
            print("must have username")
            completeSignInBtn.isEnabled = false
        }
        else {
            completeSignInBtn.isEnabled = true
        }
        guard let img = userImagePicker.image,imageSelected == true else {
            print("Image must be selected")
            return
        }
   
        guard let currentUser = Auth.auth().currentUser else { return }
        if let imgData = UIImageJPEGRepresentation(img, 0.2){
            let metadata = StorageMetadata()
            metadata.contentType = "img/jpeg"
            
            Storage.storage().reference().child(currentUser.uid).putData(imgData, metadata: metadata){
                (metadata, error) in
                if error != nil {
                    print("did not upload img")
                } else {
                    print("uploaded")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url  = downloadURL {
                        self.setUpUser(img: url)
                    }
                }
            }
        }
    }
    @IBAction func createAccount(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                   
                    print("success")
                }
                else {
                    print(error?.localizedDescription ?? "AAA")
                    return    
                }
                self.uploadImage()
                
            })
        dismiss(animated: true, completion: nil)
        
    }
    }
    
   
    
    @IBAction func selectedImagePicker(_ sender: Any){
        present(imagePicker, animated: true, completion: nil)
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

