//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Raycho Karaivanov on 15.01.18.
//  Copyright © 2018 Raycho Karaivanov. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func doneBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
