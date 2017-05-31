//
//  AddData.swift
//  ProjectOne
//
//  Created by Bohdan Laluck on 2017-05-28.
//  Copyright © 2017 Bohdan Laluck. All rights reserved.
//

import Foundation
import UIKit

class DataItem {
    var listItem: String
    var priorityItem: Int
    var statusItem: Bool
    var part: Int
    var line: Int
    
    init(listItem:String, priorityItem: Int, statusItem: Bool, part: Int, line: Int) {
        self.listItem = listItem
        self.priorityItem = priorityItem
        self.statusItem = statusItem
        self.part = part
        self.line = line
    }
}
