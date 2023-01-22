//
//  K.swift
//  Todoey
//
//  Created by webwerks on 21/12/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

enum K : String{
    case toDoItemCell = "ToDoItemCell"
    case addNewItem = "New Task To Do"
    case add = "Add to list"
    case itemArray = "toDoItemArray"
    case itemPlist = "Items.plist"
    case item = "Item"
    case dataModel = "DataModel"
}

enum KAssociated{
    case errorDiscrption(error : String)
    case userError(error : String, userInfo : String)
    
   var desc : String{
        switch self{
        case .errorDiscrption(error: let error):
            return "error occured while saving CoreData \(error)"
        case .userError(error: let error, userInfo: let userInfo):
            return "Unresolved error \(error), \(userInfo)"
        }
    }
}
