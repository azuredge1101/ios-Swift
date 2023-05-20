//
//  ViewController.swift
//  Name
//
//  Created by students on 2022/3/18.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var messageLab: UILabel!
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        UserDefaults.standard.set(textField.text, forKey: "name")
        
        messageLab.text = "我記住了"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameObj = UserDefaults.standard.object(forKey: "name")
        
        if let temp = nameObj as? String{
            
            textField.text = temp
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }


}

