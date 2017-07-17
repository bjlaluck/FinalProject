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
        
       
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture: )))
        self.view.addGestureRecognizer(longPress)
        self.view.addGestureRecognizer(tapGesture)
        
        
       
        
        
        
    }
   
    

    func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        
        if recognizer.state == .began  {
            
            let touchPoint = recognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                allItems[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func handleTap(gesture: UITapGestureRecognizer) {
        
       
        let touchPoint = gesture.location(in: self.tableView)
        if let indexPath = tableView.indexPathForRow(at: touchPoint) {
            print (indexPath)
            
            if indexPath.row == allItems[indexPath.section].count {
                dataItem = DataItem(listItem: "New Item", priorityItem: 1, statusItem: false, part: indexPath.section, line: indexPath.row)
                performSegue(withIdentifier: "infoSegue", sender: self)
            } else {
                dataItem = allItems[indexPath.section][indexPath.row]
                performSegue(withIdentifier: "infoSegue", sender: self)
            }
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
            if let recognizers = view.gestureRecognizers {
                for recognizer in recognizers {
                   view.removeGestureRecognizer(recognizer)
                }
            }


            
      }
        else {
            tableView.beginUpdates()
            
            for (index, sectionItem) in allItems.enumerated() {
                let indexPath = IndexPath(row: sectionItem.count, section: index)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
            tableView.setEditing(false, animated: true)
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture: )))
            self.view.addGestureRecognizer(longPress)
            self.view.addGestureRecognizer(tapGesture)

        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let sectionItem = allItems[indexPath.section]
        if  indexPath.row >= sectionItem.count  && isEditing {
           return .insert
        }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let sectionItem = allItems[indexPath.section]
        if indexPath.row >= sectionItem.count && isEditing{
            return false
        }
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if destinationIndexPath.section == sourceIndexPath.section {
            let section = sourceIndexPath.section
            var oldRow = sourceIndexPath.row
            var newRow = destinationIndexPath.row
            let movedEarlier = newRow < oldRow
            
            if !movedEarlier  {
                newRow += 1  }
            
            allItems[section].insert(allItems[section][oldRow], at: newRow)
            
            
            if movedEarlier {
                oldRow += 1}
            allItems[section].remove(at: oldRow)
        }
        else{
            
            
            let item = allItems[sourceIndexPath.section][sourceIndexPath.row]
            allItems[destinationIndexPath.section].insert(item, at: destinationIndexPath.row)
            allItems[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            
        }
    }
  
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        let sectionItem = allItems[proposedDestinationIndexPath.section]
        
        if sectionItem.count == 0 {
            // allows user to move item into section that is empty
            return IndexPath(row: sectionItem.count, section: proposedDestinationIndexPath.section)
        } else if proposedDestinationIndexPath.row >= sectionItem.count {
            // stops user from moving after "Add New Item" row
            return IndexPath(row: sectionItem.count - 1, section: proposedDestinationIndexPath.section)
        } else {
            return proposedDestinationIndexPath
        }
        
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let SecondVC = segue.destination as? SecondViewController{
            SecondVC.dataItem = self.dataItem
            SecondVC.myProtocol = self
            
        }
    }
    func update (dataItem:DataItem) {
        
        
        self.dataItem = dataItem
        
        let newData = DataItem(listItem: (self.dataItem?.listItem)!, priorityItem: dataItem.priorityItem, statusItem: dataItem.statusItem, part: dataItem.part, line: dataItem.line)
        
        allItems[dataItem.part].append(newData)
        self.tableView.reloadData()
        
        
    }
    
}

extension UIGestureRecognizer {
    func cancel() {
        isEnabled = false
            }
}

