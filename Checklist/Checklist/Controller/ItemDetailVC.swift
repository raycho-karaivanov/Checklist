//
//  ItemDetailVC.swift
//  Checklist
//
//  Created by Raycho Karaivanov on 15.01.18.
//  Copyright © 2018 Raycho Karaivanov. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailVC)
    func itemDetailViewController(_ controller: ItemDetailVC, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailVC, didFinishEditing item: ChecklistItem)
}


class ItemDetailVC: UITableViewController, UITextFieldDelegate {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarBtn: UIBarButtonItem!
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEtit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEtit {
            title = "Edit Item"
            textField.text = item.text
            doneBarBtn.isEnabled = true
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
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    @IBAction func doneBtnPressed(_ sender: Any) {
        if let itemToEdit = itemToEtit {
            itemToEdit.text = textField.text!
            
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEtit!)
        } else {
        let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
        
        delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
}
