//
//  ViewController.swift
//  core
//
//  Created by students on 2022/4/29.
//

import UIKit
import CoreData




class ViewController: UIViewController {

    var userlist: [Users] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = appDelegate.persistentContainer.viewContext
        let user = Users(context: myContext)
        user.username = "James"
        user.password = "123"
        user.age = 99
        
        
        
        /*
 
        do {
            try myContext.save()
            print("Data saved!")
        } catch {
            print("Data could not be saved!")
        }
         
        */
        //(UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        
        
        let fetchRequest = NSFetchRequest<Users>(entityName: "Users")
        fetchRequest.returnsObjectsAsFaults = false
        //NSPredicate(format:)
        do {
            
            userlist = try myContext.fetch(fetchRequest)
            //print(userlist)
            
            if userlist.count > 0 {
                fot user in userlist {
                    print(user.username)
                    print(user.password)
                    print(user.age)
                    
                }
                
                
            }
            
            
        } catch {
            
            
            print("Data could not be fetched!")
        }
 
        
 
 
 
        /*
        if let coreDataItems = try? myContext.fetch(Users.fetchRequest()) as [Users] {
            
            
            NSFetchRequest(entityName: "Users").returnsObjectsAsFaults = false
            print(coreDataItems)
            
            
            
        }
        */
        
        
    }


}

