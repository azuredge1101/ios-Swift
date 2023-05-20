//
//  ViewController.swift
//  Login Coredata
//
//  Created by admin on 2022/4/29.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    var userlist: [Users] = []
    
    
    @IBOutlet weak var userInput: UITextField!
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        
        
        save()
        
        
        
    }
    
    
    
    func save() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let user = Users(context: context)
        
        if !userInput.text!.isEmpty {
            //save
            user.username = userInput.text
            
            
        }
        
        
        do {
            try context.save()
            print("data saved")
            
        } catch {
            
            print("save unsuccessfully")
        }
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

