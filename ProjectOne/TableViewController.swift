//
//  ViewController.swift
//  ProjectOne
//
//  Created by Bohdan Laluck on 2017-05-28.
//  Copyright © 2017 Bohdan Laluck. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
     var workItems = [DataItem]()
     var homeItems = [DataItem]()
     var  allItems = [[DataItem]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        automaticallyAdjustsScrollViewInsets = false
                navigationItem.rightBarButtonItem = editButtonItem
        
        workItems.append(DataItem(listItem: "Schedule meeting", priorityItem: 1, statusItem: false))
        workItems.append(DataItem(listItem: "Call client", priorityItem: 1, statusItem: false))
        
        homeItems.append(DataItem(listItem: "Pay bills", priorityItem: 1, statusItem: false))
        homeItems.append(DataItem(listItem: "Empty lunch bag", priorityItem: 1, statusItem: false))
        
        allItems.append(workItems)
        allItems.append(homeItems)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let addedRow = isEditing ? 1 : 0
        return allItems[section].count + addedRow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.row >= allItems[indexPath.section].count && isEditing {
            cell.textLabel?.text = "Add new Item"
            cell.detailTextLabel?.text = String(1)
            
        }
        else {
            let item = allItems[indexPath.section][indexPath.row]
            
        cell.textLabel?.text = item.listItem
        cell.detailTextLabel?.text = String(item.priorityItem)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
                return "To Do at Work"
        }
        else {
            return "To Do at Home"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allItems[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade
            )
        }
        if editingStyle == .insert {
            performSegue(withIdentifier: "infoSegue", sender: self)
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            tableView.beginUpdates()
            
            for (index, sectionItem) in allItems.enumerated() {
                let indexPath = IndexPath(row: sectionItem.count, section: index)
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
            tableView.setEditing(true, animated: true)
        }
        else {
            tableView.setEditing(false, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let sectionItem = allItems[indexPath.section]
        if indexPath.row >= sectionItem.count && isEditing {
            return .insert
        }
        return .delete
    }
}
