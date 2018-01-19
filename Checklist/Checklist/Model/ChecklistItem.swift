//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Raycho Karaivanov on 12.01.18.
//  Copyright © 2018 Raycho Karaivanov. All rights reserved.
//

import Foundation
class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int

    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    func toggleChecked(){
        checked = !checked
    }
    
    
}
