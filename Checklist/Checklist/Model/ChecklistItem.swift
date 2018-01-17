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
    
    func toggleChecked(){
        checked = !checked
    }
}
