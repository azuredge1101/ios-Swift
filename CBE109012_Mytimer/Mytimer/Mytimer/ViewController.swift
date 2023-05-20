//
//  ViewController.swift
//  Mytimer
//
//  Created by students on 2022/3/11.
//

import UIKit

class ViewController: UIViewController {
    
    
    var myTimer = Timer()
    var time : Int = 0
    var isStart : Bool = false
    
    @IBOutlet weak var timeLab: UILabel!
    
    
    @IBAction func palyButton(_ sender: UIBarButtonItem) {
        
        
        if !isStart{
        
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processor), userInfo: nil, repeats: true)
            
            isStart = true
            myTimer.fire()
        
        }else{
            myTimer.invalidate()
            
            isStart = false
        }
        
        
        
    
    }
    @objc func processor() {
        time = time+1
        timeLab.text = String(time)
    }
    
    @IBAction func pauseButton(_ sender: UIBarButtonItem) {
        
            myTimer.invalidate()
            
            isStart = false
        }
    
    
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        myTimer.invalidate()
        isStart = false
        time = 0
        timeLab.text = String(time)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

