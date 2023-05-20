//
//  ViewController.swift
//  myUberApp
//
//  Created by students on 2022/5/13.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var riderSwitch: UISwitch!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func signInButton(_ sender: UIButton) {
        if inputEmail.text != "" && passwordInput.text != "" {
            //身份驗證
            authService(email: inputEmail.text!, password: passwordInput.text!)
            
        } else {
            displayAlert(title: "Sign In Error", message: "Please enter your email and password.")
        }
    }
    
    func authService(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
            if error != nil{
                let errorStr = (error as! NSError).userInfo["FIRAuthErrorUserInfoNameKey"]
                
                if errorStr as! String == "ERROR_USER_NOT_FOUND" {
                    Auth.auth().createUser(withEmail: email, password: password){ (result ,error) in
                        if error != nil{
                            self.displayAlert(title: "Create Account Error", message: (error?.localizedDescription)!)
                        } else {
                            //print("Create Account Successfully")
                            if self.riderSwitch.isOn{
                                let changeReq = Auth.auth().currentUser?.createProfileChangeRequest()
                                
                                changeReq?.displayName = "rider"
                                changeReq?.commitChanges(completion: nil)
                                
                                self.performSegue(withIdentifier: "riderSegue", sender: self)
                            } else {
                                let changeReq = Auth.auth().currentUser?.createProfileChangeRequest()
                                
                                changeReq?.displayName = "driver"
                                changeReq?.commitChanges(completion: nil)
                                
                                self.performSegue(withIdentifier: "driverSegue", sender: self)
                            }
                        }
                    }
                } else {
                    self.displayAlert(title: "Sign In Error", message: (error?.localizedDescription)!)
                    
                }
            } else {
                //print("User Signed In Successfully!")
                if result?.user.displayName == "rider" {
                    self.performSegue(withIdentifier: "riderSegue", sender: self)
                } else {
                    self.performSegue(withIdentifier: "driverSegue", sender: self)
                }
                
            }
        }
    }
    func displayAlert(title: String, message: String) {
        let alertControoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertControoller.addAction(alertAction)
        
        self.present(alertControoller, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

