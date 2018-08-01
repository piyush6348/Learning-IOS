//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Piyush Gupta on 01/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    // instance variables
    var dataArray: [Category] = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: - TableView data source methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = dataArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    //MARK: - Data manipulation methods
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error encoding data \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        //let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            dataArray = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print("Error while loading data \(error)")
        }
    }
    
    //MARK: - Add new categories
    @IBAction func addSectionBtnClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Section", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Success")
            print("Hey " + alert.textFields![0].text!)
            
            let textEntered = alert.textFields![0].text!
            let category = Category(context: self.context)
            category.name = textEntered
            
            self.dataArray.append(category)
            self.saveData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter some text"
            print(textField.text!)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToSection", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToSection"){
            let destinationVC = segue.destination as! ViewController
            
            // since we come here only when category is selected so this will be always true
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedCategory = dataArray[indexPath.row]
            }
        }
    }
}
