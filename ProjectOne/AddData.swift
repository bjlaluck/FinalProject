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
    
    init(listItem:String, priorityItem: Int, statusItem: Bool) {
        self.listItem = listItem
        self.priorityItem = priorityItem
        self.statusItem = statusItem
    }
}
