//
//  ViewController.swift
//  TableApp
//
//  Created by students on 2022/3/18.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var TableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        
        cell.textLabel?.text = String(Int(Slider.value * 20) * (indexPath.row + 1))
        
        return cell
    }
    

    
    @IBOutlet weak var Slider: UISlider!
    
    @IBAction func SliderChange(_ sender: Any) {
        
        //print(Slider.value)
        TableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

