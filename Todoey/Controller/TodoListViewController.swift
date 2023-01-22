//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    
    //MARK: IBOutlets

    var itemArray : [Item] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.itemPlist.rawValue)
    
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
        cell.textLabel?.text = task.title
        cell.accessoryType = task.isCheck ? .checkmark : .none
        return cell
    }
    
    //MARK: - Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        itemArray[indexPath.row].isCheck = !itemArray[indexPath.row].isCheck
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
                let newItem = Item(context: self.context)
                newItem.title = taskName
                newItem.isCheck = false
                self.itemArray.append(newItem)
                self.saveData()
            }
        }
        controller.addAction(alertAction)
        self.present(controller, animated: true)
    }
    
    func saveData(){
       
        do {
            try context.save()
        } catch  {
            print(KAssociated.errorDiscrption(error: "\(error)"))
        }
        self.tableView.reloadData()
    }
    
    
    func getData(){
        do {
            let request : NSFetchRequest<Item> = NSFetchRequest(entityName: K.item.rawValue)
            itemArray =   try context.fetch(request)
        } catch let error {
            print(error)
        }
        self.tableView.reloadData()
    }
    
}



