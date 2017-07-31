//
//  ViewController.swift
//  DanceApp
//
//  Created by mac on 25.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FirebaseDatabase
import FirebaseAuth



class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        self.navigationController?.navigationBar.isHidden = false
        self.imageView.image = #imageLiteral(resourceName: "logotype")
        self.appNameLabel.text = "Dancely"
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 32, y: 459, width: view.frame.width - 45, height: 46)
        signButton.layer.masksToBounds = true
        signButton.backgroundColor =  .orange
        signButton.setTitle("Войти", for: .normal)
        signButton.setTitleColor(.white, for: .normal)
       signButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//       signButton.addTarget(self, action: #selector(handledCustomFBLogin), for: .touchUpInside)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            //self.presentLoggedInScreen()
             print("success")
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                   
                }
                print("success")
                if user != nil {
                    self.presentLoggedInScreen()
                }
            })
        }
    }
    @IBAction func forgotPasswordTapped(_ sender: Any) {
    }
    func handledCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self)
        { (result, err) in
            if err != nil {
                print("Custom FB login failed")
                return
            }
            self.showEmailAddress()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
        }
    
    func showEmailAddress(){
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        print("credential\(credentials)")
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            print("created")
        })

        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, gender, age_range"]).start {
            (connection, result, err) in
            if err != nil {
                print("failed to start graph request:", err ?? "")
                return
            }
            
            print(result ?? "")
        }

    }
    
    func presentLoggedInScreen() {
        print("present logged in screen")
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInVC:PeopleViewController = storyBoard.instantiateViewController(withIdentifier: "PeopleViewController") as! PeopleViewController
        self.present(loggedInVC, animated: true, completion: nil)
    }
}

