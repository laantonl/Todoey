//
//  ViewController.swift
//  Todoey
//
//  Created by Anthony Anton on 16/11/18.
//  Copyright © 2018 Anthony Anton. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Cosa1","Cosa2","Cosa3"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - TableView Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    //MARK - Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - ADD New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let Alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //print(textField.text)
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        Alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "Create new item"
            textField = AlertTextField
        }
        
        Alert.addAction(action)
        present(Alert, animated: true,completion: nil)
    }
    
}

