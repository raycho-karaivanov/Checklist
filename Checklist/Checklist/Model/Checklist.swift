//
//  Checklist.swift
//  Checklist
//
//  Created by Raycho Karaivanov on 17.01.18.
//  Copyright © 2018 Raycho Karaivanov. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {

    var name = ""
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    func counUncheckedItems() -> Int {
//        var count = 0
//
//        for item in items where !item.checked {
//            count += 1
//        }
//        return count
//      is The Same like this:
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
}
