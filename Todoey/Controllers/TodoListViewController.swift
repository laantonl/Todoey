//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Anton on 16/11/18.
//  Copyright © 2018 Anthony Anton. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //var itemArray = ["Cosa1","Cosa2","Cosa3"]
    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    let dataPathFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(dataPathFile)
//        let newItem = Item()
//        newItem.title = "Cosa 1"
//        newItem.done = false
//
//        itemArray.append(newItem)
        
        loadData()
        //if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
        //    itemArray = items
        //}
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - TableView Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == false ? .none : .checkmark
        
        return cell
    }

    //MARK - Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - ADD New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let Alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //print(textField.text)
            
            let newItem = Item()
            newItem.title = textField.text!
            newItem.done = true
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        Alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "Create new item"
            textField = AlertTextField
        }
        
        Alert.addAction(action)
        present(Alert, animated: true,completion: nil)
    }
    
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataPathFile!)
        }catch
        {
            print("Error al grabar items \(error) ")
        }
        
        tableView.reloadData()
    }
    
    func loadData()
    {
        
        if let data = try? Data(contentsOf: dataPathFile!){
            do {
                let decoder = PropertyListDecoder()
                itemArray = try decoder.decode([Item].self, from: data)

            } catch {
                print("Error a Cargar \(error)")
            }

        }
    
    }
    
}

