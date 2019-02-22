//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iimjobs on 11/02/19.
//  Copyright © 2019 iimjobs. All rights reserved.
//


import Foundation

class ChecklistItem: NSObject {
    
    var text = ""
    var checked = false
    
    func toggleChecked()
    {
        checked = !checked
    }
    
}
