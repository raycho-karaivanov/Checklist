//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Raycho Karaivanov on 15.01.18.
//  Copyright © 2018 Raycho Karaivanov. All rights reserved.
//

import UIKit
protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinisheAdding item: ChecklistItem)
}


class AddItemViewController: UITableViewController, UITextFieldDelegate {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarBtn: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate?
    var itemToEtit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEtit {
            title = "Edit Item"
            textField.text = item.text
        }
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneBarBtn.isEnabled = !newText.isEmpty
        
        return true
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func doneBtnPressed(_ sender: Any) {
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        
        delegate?.addItemViewController(self, didFinisheAdding: item)
        
    }
}
