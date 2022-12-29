//
//  Item.swift
//  Todoey
//
//  Created by webwerks on 22/12/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct Item : Codable{
    var taskName : String?
    var isCompleted : Bool = false
}
