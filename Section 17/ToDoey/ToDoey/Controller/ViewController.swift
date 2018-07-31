//
//  ViewController.swift
//  ToDoey
//
//  Created by Piyush Gupta on 31/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    // Instance variables
    var itemArray: [ToDo2] = [ToDo2]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
     //shared prefs
    // let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let items = defaults.array(forKey: "toDoList") as? [ToDo2] {
//            itemArray = items
//        }
    }
    
    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCellIdentifier", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        if(item.done){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Items
    
    @IBAction func AddBtnClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success")
            print("Hey " + alert.textFields![0].text!)
            
            let textEntered = alert.textFields![0].text!
            let todo = ToDo2()
            todo.title = textEntered
            
            self.itemArray.append(todo)
            
            let encoder = PropertyListEncoder()
            do{
                let encodedData = try encoder.encode(self.itemArray)
                try encodedData.write(to: self.dataFilePath!)
            }catch{
                print("Error encoding data")
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter some text"
            print(textField.text!)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

