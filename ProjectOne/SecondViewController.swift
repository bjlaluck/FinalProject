//
//  SecondViewController.swift
//  ProjectOne
//
//  Created by Bohdan Laluck on 2017-05-29.
//  Copyright © 2017 Bohdan Laluck. All rights reserved.
//

import UIKit


protocol MyProtocol {
    func update (dataItem:DataItem)
}


class SecondViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var textField: UITextField!
    
    var myProtocol: MyProtocol?
    
    var dataItem: DataItem?
    
    
    @IBOutlet weak var textDetailsLabel: UILabel!
    
    
    
    @IBAction func savePress(_ sender: Any) {
         if let myProtocol = self.myProtocol, let listItem = textField.text, let priorityItem = dataItem?.priorityItem, let statusItem = dataItem?.statusItem, let part = dataItem?.part, let line = dataItem?.line
         { let dataItem: DataItem = DataItem(listItem: listItem, priorityItem: priorityItem, statusItem: statusItem, part: part, line: line)
            myProtocol.update(dataItem: dataItem)
            

        }
           
       self.navigationController?.popToRootViewController(animated: true)

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = self.dataItem{
            textField.text = data.listItem
            
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
