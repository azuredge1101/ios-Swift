//
//  SecondViewController.swift
//  Note
//
//  Created by students on 2022/3/18.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var inputText: UITextField!
    
    
    @IBAction func savelist(_ sender: UIButton) {
        
        var itemList : [String]
        
        let userObj = UserDefaults.standard.object(forKey: "userEntry")
        
        if inputText.text != "" {
            if let tempObj = userObj as? [String]{
                
                itemList = tempObj
                
                itemList.append(inputText.text!)
                
                print(itemList)
                
                
            }
            else {
                itemList = [inputText.text!]
                
            }
            UserDefaults.standard.set(itemList, forKey: "userEntry")
            
            inputText.text = ""
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
