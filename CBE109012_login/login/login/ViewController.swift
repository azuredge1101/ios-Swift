//
//  ViewController.swift
//  login
//
//  Created by students on 2022/4/15.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var loginLab: UILabel!
    
    @IBOutlet weak var loginview: UIView!
    
    @IBOutlet weak var buttonview: UIView!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    
    @IBAction func rotatingButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1) {
            
            if self.buttonview.transform == CGAffineTransform.identity {
            
            self.buttonview.transform = CGAffineTransform(scaleX: 30, y: 30)
            self.buttonview.transform = CGAffineTransform(translationX: 0, y: -300)
            self.titleLab.transform = CGAffineTransform(translationX: 0, y: -300)
            self.loginLab.transform = CGAffineTransform(translationX: 0, y: -300)
            self.loginview.transform = CGAffineTransform(translationX: 0, y: -300)
            
            
            
                
                
        }else{
            
            self.buttonview.transform = CGAffineTransform.identity
        }
   
    }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        buttonview.layer.cornerRadius = buttonview.frame.width / 2
    }


}

