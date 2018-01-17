//
//  ListDetailVC.swift
//  Checklist
//
//  Created by Raycho Karaivanov on 17.01.18.
//  Copyright © 2018 Raycho Karaivanov. All rights reserved.
//

import UIKit

protocol ListDtailVCDelegate : class {
    func listDetailVCDidCancel(_ controller: ListDetailVC)
    func listDetailVC(_ controller: ListDetailVC, didFinishAdding checklist: Checklist)
    func listDetailVC(_ controller: ListDetailVC, didFinishEditing checklist: Checklist)
}

class ListDetailVC : UITableViewController, UITextFieldDelegate {
    
    // MARK:- Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDtailVCDelegate?
    var checklistToEdit: Checklist?
    
    // MARK:- ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK:- TableView Delegates
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK:- UITextField Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    // MARK:- Actions
    
    @IBAction func cancel() {
        delegate?.listDetailVCDidCancel(self)
    }
    
    @IBAction func done(){
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            delegate?.listDetailVC(self, didFinishEditing: checklist)
        } else {
            let checklist = Checklist(name: textField.text!)
            delegate?.listDetailVC(self, didFinishAdding: checklist)
        }
    }
}
