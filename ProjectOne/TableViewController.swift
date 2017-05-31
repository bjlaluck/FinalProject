//
//  ViewController.swift
//  ProjectOne
//
//  Created by Bohdan Laluck on 2017-05-28.
//  Copyright © 2017 Bohdan Laluck. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyProtocol {
    @IBOutlet weak var tableView: UITableView!
    
     var workItems = [DataItem]()
     var homeItems = [DataItem]()
     var  allItems = [[DataItem]]()
    
    var aa: String = ""
    var bb: Int = 0
    var cc: Bool = false
    var dd: Int = 0
    var ee: Int = 0
    
    
    
    var dataItem: DataItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        automaticallyAdjustsScrollViewInsets = false
                navigationItem.rightBarButtonItem = editButtonItem
        
        workItems.append(DataItem(listItem: "Schedule meeting", priorityItem: 1, statusItem: false, part: 0, line: 0))
        workItems.append(DataItem(listItem: "Call client", priorityItem: 1, statusItem: false, part: 0, line: 0))
        
        homeItems.append(DataItem(listItem: "Pay bills", priorityItem: 1, statusItem: false, part: 0, line: 0))
        homeItems.append(DataItem(listItem: "Empty lunch bag", priorityItem: 1, statusItem: false, part: 0, line: 0))
        
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
            dataItem = DataItem(listItem: "New Item", priorityItem: 1, statusItem: false, part: indexPath.section, line: indexPath.row)
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
            tableView.beginUpdates()
            
            for (index, sectionItem) in allItems.enumerated() {
                let indexPath = IndexPath(row: sectionItem.count, section: index)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let SecondVC = segue.destination as? SecondViewController{
            SecondVC.dataItem = self.dataItem
            SecondVC.myProtocol = self
            
        }
    }
    func update (dataItem:DataItem) {
          self.dataItem = dataItem
            aa = (self.dataItem?.listItem)!
            bb = (self.dataItem?.priorityItem)!
            cc = (self.dataItem?.statusItem)!
            dd = (self.dataItem?.part)!
            ee = (self.dataItem?.line)!
        
        
        
        let newData = DataItem(listItem: aa, priorityItem: bb, statusItem: true, part: dd, line: ee)
        
         allItems[dd].append(newData)
        let indexPath = IndexPath(row: ee, section: dd)
         tableView.insertRows(at: [indexPath], with: .fade)
        
    }
    
}

