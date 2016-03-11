//
//  ViewController.swift
//  tracking
//
//  Created by Kimate Richards on 2/26/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    var listItems = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addItem"))
    }
    
    func addItem(){
        let alertController = UIAlertController(title: "Hello people", message: "What's up?", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Hello people", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            if let field = alertController.textFields![0] as? UITextField {
                self.saveItem(field.text!)
                self.tableView.reloadData()
            }
        }
    ))
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addTextFieldWithConfigurationHandler({
            (textField)in
            textField.placeholder = "Typing stuff"
        })
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
    }
    
    func saveItem(itemToSave : String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("MapEntity", inManagedObjectContext: managedContext)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        item.setValue(itemToSave, forKey: "item")
        
        do {
            try managedContext.save()
            listItems.append(item)
        }
        catch{
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        return cell
    }
}

