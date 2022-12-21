//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    //MARK: IBOutlets
    var itemArray : [String] = ["apple","banana","cherry"]
    
    
    //MARK: viewDidLad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:  cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.toDoItemCell.rawValue, for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: - Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - IBActions
extension TodoListViewController{
    @IBAction func addNewItemPressed(_ sender: Any) {
        let controller = UIAlertController(title: K.addNewItem.rawValue, message: nil, preferredStyle: .alert)
        controller.addTextField { txtfield in
            txtfield.layer.borderWidth = 1
            txtfield.layer.borderColor = UIColor.systemBlue.cgColor
            
        }
        let alertAction = UIAlertAction(title: K.add.rawValue, style: .cancel) { action in
            //print("success")
            let item = controller.textFields?[0].text ?? ""
            if  !item.isEmpty {
                self.itemArray.append(item)
                self.tableView.reloadData()
            }
        }
        controller.addAction(alertAction)
        self.present(controller, animated: true)
    }
    
}


