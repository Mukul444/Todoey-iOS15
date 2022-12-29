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
    let item1 = Item(taskName: "apple", isCompleted: false)
    let item2 = Item(taskName: "banana", isCompleted: false)
    let item3 = Item(taskName: "cherry", isCompleted: false)
    var itemArray : [Item] = []
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //MARK: viewDidLad
    override func viewDidLoad() {
        super.viewDidLoad()
       // itemArray = [item1,item2,item3,]
        getData()
    }
    
    
    //MARK: - DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:  cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.toDoItemCell.rawValue, for: indexPath)
        let task = itemArray[indexPath.row]
        cell.textLabel?.text = task.taskName
        cell.accessoryType = task.isCompleted ? .checkmark : .none
        return cell
    }
    
    //MARK: - Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].isCompleted = !itemArray[indexPath.row].isCompleted
        self.saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
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
            let taskName = controller.textFields?[0].text ?? ""
            if  !taskName.isEmpty {
                let item = Item(taskName: taskName, isCompleted: false)
                self.itemArray.append(item)
                self.saveData()
            }
        }
        controller.addAction(alertAction)
        self.present(controller, animated: true)
    }
    
    func saveData(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.filePath!)
        } catch let error {
            print(error)
        }
        self.tableView.reloadData()
    }
    
    func getData(){
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: filePath ?? URL(fileURLWithPath: ""))
            let dataItemArray = try decoder.decode([Item].self, from: data)
            itemArray = dataItemArray
        } catch let error {
            print(error)
        }
        self.tableView.reloadData()
    }
    
}



