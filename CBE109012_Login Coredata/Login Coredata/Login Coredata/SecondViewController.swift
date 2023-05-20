//
//  SecondViewController.swift
//  Login Coredata
//
//  Created by admin on 2022/4/29.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = userlist[indexPath.row].username
        
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    
    var userlist: [Users] = []

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        fetch()
        

        
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//
////        UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "Delete?") { (rowAction, indexPath) in
////
////
////
////        }
//        UIContextualAction(style: UIContextualAction.Style.destructive, title: "Delete?") { (textAction, self, @escaping (Bool) -> Void) in
//            <#code#>
//        }
//
//
//    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete?") { (contextAction, tableView, true) in
            
            
            //要更新資料庫
            self.deleteItem(indexPath: indexPath)
            //重抓資料庫內容
            self.fetch()
            //畫面呈現新的結果
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

            return swipeActions
        
    }
    
    
    func deleteItem(indexPath: IndexPath){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(userlist[indexPath.row])
        
        
        do {
            try context.save()
        } catch  {
            print("database item deletion fail!")
        }
        
    }
    
    
    
    func fetch()  {
            
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Users>(entityName: "Users")
        
        do {
                userlist = try context.fetch(fetchRequest)
            
            
        } catch  {
                print("Data can not be fetched!")
        }
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
