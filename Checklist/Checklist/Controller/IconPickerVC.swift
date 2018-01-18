//
//  IconPickerVC.swift
//  Checklist
//
//  Created by Raycho Karaivanov on 18.01.18.
//  Copyright © 2018 Raycho Karaivanov. All rights reserved.
//

import UIKit

protocol IconPickerVCDelegate: class {
    func iconPicker(_ picker: IconPickerVC, didPick iconName: String)
}

class IconPickerVC: UITableViewController {
    weak var delegate: IconPickerVCDelegate?
    let icons = [ "No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips" ]
    
    // MARK:- Table View Delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPick: iconName)
        }
    }
}
