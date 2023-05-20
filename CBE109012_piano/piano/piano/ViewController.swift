//
//  ViewController.swift
//  piano
//
//  Created by students on 2022/4/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioplayer: AVAudioPlayer?
    let soundArray = ["Sound1","Sound2","Sound3","Sound4","Sound5"]
    
    @IBAction func bitton1(_ sender: UIButton) {
        
        var soundFilename : String = soundArray[sender.tag - 1]
        
        playSound(filename: soundFilename)
        
    }
    
    func playSound(filename: String){
        
        let url = Bundle.main.url(forResource: "Sound/\(filename)", withExtension: "wav")
        
        do {
            audioplayer = try AVAudioPlayer(contentsOf: url!)
        } catch  {
            print("audio cannot be played")
        }
        
        
        audioplayer?.play()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

