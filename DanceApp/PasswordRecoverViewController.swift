//
//  PasswordRecoverViewController.swift
//  DanceApp
//
//  Created by mac on 01.08.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordRecoverViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func recoverPassowrdTapped(_ sender: Any) {
       
        if let userEmail = emailTextField.text {
        Auth.auth().sendPasswordReset(withEmail: userEmail, completion: { (error) in

            if error != nil
            {
                let errorAlertController = UIAlertController(title: "Unidentified Email Address", message: "Please, re-enter the email you have registered with.", preferredStyle: .alert)
                errorAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(errorAlertController, animated: true, completion: nil)
               // self.dismiss(animated: true, completion: nil)
            }
            
            else
            {
                let alertController = UIAlertController(title: "Email Sent", message: "An email has been sent. Please, check your email now.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
            })
        
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        print("oj")
//        
//        DispatchQueue.main.async {
//            self.dismiss(animated: true, completion: {
//                print("ended")
//            })
//        }
//        
        self.dismiss(animated: true, completion: {
            print("ended")
        })
    }

}
