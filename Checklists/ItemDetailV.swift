//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by iimjobs on 12/02/19.
//  Copyright © 2019 iimjobs. All rights reserved.
//

import UIKit


protocol AddItemTableViewControllerDelegate : class
{
    func addItemViewControllerDidCancel(_ controller: ItemDetailV)
    func addItemViewController(_ controller: ItemDetailV , didFinishAdding item : ChecklistItem)
    
    func addItemViewController(_controller: ItemDetailV ,
                               didFinishEditing item : ChecklistItem)
}
class ItemDetailV: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    var itemtoEdit : ChecklistItem?
    
    weak var Delegate: AddItemTableViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemtoEdit {
            title = " Edit item "
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
      

    }
    
    @IBAction func cancel(_ sender: Any) {
        
         navigationController?.popViewController(animated: true)
        Delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func done(_ sender: Any) {
        
        
        if let itemtoEdit = itemtoEdit {
            itemtoEdit.text = textField.text!
            Delegate?.addItemViewController(_controller: self, didFinishEditing: itemtoEdit)
        }
        
        else {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            navigationController?.popViewController(animated: true)
            Delegate?.addItemViewController(self, didFinishAdding: item)
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range , in: oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        
        
        if newText.isEmpty
        {
            doneBarButton.isEnabled = false
        }
        
        else
        {
            doneBarButton.isEnabled = true
        }
        
        return true
    }
    
    
}

