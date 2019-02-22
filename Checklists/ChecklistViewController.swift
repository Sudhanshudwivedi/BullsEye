//
//  ViewController.swift
//  Checklists
//
//  Created by iimjobs on 11/02/19.
//  Copyright © 2019 iimjobs. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemTableViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_controller: ItemDetailV, didFinishEditing item: ChecklistItem) {
        if let index = items.index(of: item)
        {
            let indexpath = IndexPath(row: index, section: 0)
            
            if let cell = tableView.cellForRow(at: indexpath)
            {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)

    }
    
    func addItemViewController(_ controller: ItemDetailV, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = items.count
        items.append(item)
        let indexpath = IndexPath(row: newRowIndex, section: 0)
        let indexpaths = [indexpath]
        tableView.insertRows(at: indexpaths, with: .automatic)
        
        
        
        
        
        navigationController?.popViewController(animated: true)
    }
    
    
    var items: [ChecklistItem]
    
    @IBAction func addItem(_ sender: Any) {
        
        let newRowIndex = items.count
        let item = ChecklistItem()
        //item.text = " I am a new row"
        
        
        var titles = ["Empty to do item" , "Generic Todo" , "First to do: fill me out",
                      "I need something to do" , "Much to do about nothing" ]
        
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        
        let title = titles[Int(randomNumber)]
        
        item.text = title
        
        
        
        item.checked = false
        
        items.append(item)
        
        let indexpath = IndexPath(row: newRowIndex, section: 0)
        let indexpaths = [indexpath]
        tableView.insertRows(at: indexpaths, with: .automatic)
        
    }
    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        
        let row0Item = ChecklistItem()
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        items.append(row0Item)
        
        let row1Item = ChecklistItem()
        row1Item.text = "Brush my teeth"
        row1Item.checked = false
        items.append(row1Item)
        
        let row2Item = ChecklistItem()
        row2Item.text = "Learn iOS development"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = ChecklistItem()
        row3Item.text = "Soccer pratice"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = ChecklistItem()
        row4Item.text = "Eat ice cream"
        row4Item.checked = false
        items.append(row4Item)
        
        let row5Item = ChecklistItem()
        row5Item.text = "Watching game of thrones "
        row5Item.checked = false
        items.append(row5Item)
        
        let row6Item = ChecklistItem()
        row6Item.text = "Take a nap"
        row6Item.checked = false
        items.append(row6Item)
        
        let row7Item = ChecklistItem()
        row7Item.text = "Read a novel"
        row7Item.checked = false
        items.append(row7Item)
        
        super.init(coder: aDecoder)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"
        {
            let controller = segue.destination as! ItemDetailV
            controller.Delegate = self
        }
        else if segue.identifier == "EditItem"
        {
            let controller = segue.destination as! ItemDetailV
            controller.Delegate = self
            if let indexpath = tableView.indexPath(for: sender as! UITableViewCell)
            {
                controller.itemtoEdit = items[indexpath.row]
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexpaths = [indexPath]
        tableView.deleteRows(at: indexpaths, with: .fade
    )

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureCheckmark(for: cell, with: item)
        configureText(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell : UITableViewCell, with item : ChecklistItem)
    {
         let label = cell.viewWithTag(1000) as! UILabel
         label.text = item.text
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item : ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
      
        if item.checked {
           label.text = "√"
        } else {
          label.text = " "
        }
    }
    
}


