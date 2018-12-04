//
//  ViewController.swift
//  ToDo List
//
//  Created by S M HEMEL on 3/12/18.
//  Copyright © 2018 S M HEMEL. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    //it is find this app documnet location
    //create Items.plist to the location and saved data to the plist
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            if textField.text != nil {
                
                let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                self.itemArray.append(newItem)
                self.saveItems()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Model Manupulation Methods
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            
        }
        self.tableView.reloadData()
    }
    
    //MARK - Save Item in the Array
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) { //last one is default
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching \(error)")
        }
    }
    
}


//MARK: - Search bar methods

extension TodoListViewController:  UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let requset: NSFetchRequest<Item> = Item.fetchRequest()
        requset.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        requset.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: requset)
        
        //Print(searchBar.text!)
    }
}
