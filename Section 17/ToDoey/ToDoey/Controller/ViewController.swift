//
//  ViewController.swift
//  ToDoey
//
//  Created by Piyush Gupta on 31/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController{
    
    // Instance variables
    var itemArray: [Item] = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // getting location of our db
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
    }
    
    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCellIdentifier", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.titlle
        
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
        
        // Delete data
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            saveData()
        // -----------
//            itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//            saveData()
//            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Items
    
    @IBAction func AddBtnClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success")
            print("Hey " + alert.textFields![0].text!)
            
            let textEntered = alert.textFields![0].text!
            let item = Item(context: self.context)
            item.titlle = textEntered
            
            self.itemArray.append(item)
            self.saveData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter some text"
            print(textField.text!)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK :- Core Data
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error encoding data \(error)")
        }
        self.tableView.reloadData()
    }

    func loadData(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print("Error while loading data \(error)")
        }
    }
}

//MARK: - Search Bar methods
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        print(searchBar.text!)
    }
}

