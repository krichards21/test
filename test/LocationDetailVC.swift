//
//  LocationDetailVC.swift
//  test
//
//  Created by Kimate Richards on 3/17/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class LocationDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var dateTxt: UITextField!
    var location: SWLocation!
    @IBOutlet weak var clusterTxt: UITextField!
    var fetchedProduct = [ProductEntity]()
    @IBOutlet weak var cbfTxt: UITextField!
    @IBOutlet weak var schematicTxt: UITextField!
    @IBOutlet weak var largestTxt: UITextField!
    @IBOutlet weak var classTxt: UITextField!
    @IBOutlet weak var submitReportBtn: UIButton!
    @IBOutlet weak var podTxt: UITextField!
    @IBOutlet weak var totalCasesTxt: UITextField!
    @IBOutlet weak var displayTxt: UITextField!
    @IBOutlet weak var coldSwtch: UISwitch!
    
    let url = "\(URL_BASE)\(URL_PRODUCT_CONTROLLER)"
    
    let managedObjectContext = DataController().managedObjectContext
    @IBOutlet weak var displaySwtch: UISwitch!
    @IBOutlet weak var productPicker: UIPickerView!

    @IBAction func submitBtn(sender: AnyObject) {
    }
    @IBOutlet weak var locationName: UILabel!
    
    var productSelected = 0
    var selectedDate: String!
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        locationName.text = location.locationName
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        let date = NSDate()

        selectedDate = dateFormatter.stringFromDate(date)
        dateTxt.text = selectedDate
        productPicker.delegate = self
        productPicker.dataSource = self
        
        self.deleteAllData()
        
        downloadProduct(){ completion in
            if completion {
                self.loadProducts()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dateTimeEditing(sender: UITextField) {
        let datePicker:UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(LocationDetailVC.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        selectedDate = dateFormatter.stringFromDate(sender.date)
        dateTxt.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fetchedProduct[row].productName
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fetchedProduct.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        productSelected = row
        // get  date and location
        let inventoryRequest = NSFetchRequest(entityName: "InventoryEntity")
        do{
//            inventoryFetch.predicate = NSPredicate(format: "productID = %@ AND dateCollected = %@", productSelected, selectedDate)
            let locationPred = NSPredicate(format: "productID == \(productSelected) AND dateCollected == %@", selectedDate)
            inventoryRequest.predicate = locationPred
            let fetchedInventory = try managedObjectContext.executeFetchRequest(inventoryRequest) as! [InventoryEntity]
            for inv in fetchedInventory
            {
                print (inv.dateCollected)
            }
        }catch{
            fatalError("Could not fetch data: \(error)")
        }
    }
    
    @IBAction func submitButtonClicked(sender: AnyObject) {
        do{
        let entity = NSEntityDescription.insertNewObjectForEntityForName("InventoryEntity", inManagedObjectContext: self.managedObjectContext) as! InventoryEntity
            
            entity.setValue(coldSwtch.on, forKey: "displayBrands")
            entity.setValue(productSelected, forKey: "productID")
            entity.setValue(location.locationID, forKey: "locationID")
            entity.setValue(selectedDate, forKey: "dateCollected")
            
            try self.managedObjectContext.save()
            
        }catch{
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func loadProducts(){
        let productFetch = NSFetchRequest(entityName: "ProductEntity")
        do{
            
            fetchedProduct = try managedObjectContext.executeFetchRequest(productFetch) as! [ProductEntity]
            productPicker.reloadAllComponents()
        }catch{
            fatalError("ooooo \(error)")
        }
    }
    
    func downloadProduct(completionHandler:(Bool) -> ()){
        let productURL = NSURL(string: "\(URL_BASE)product/getproducts/")!
        let parameters = [
            "ServiceProvider": SERVICE_PROVIDER
        ]
        Alamofire.request(.GET, productURL, parameters: parameters).responseJSON {
            response in
            let result = response.result
            if result.isSuccess
            {
                let json = JSON(response.result.value!)
                for jsonArrayNode in json.array!
                {
                    let productName = jsonArrayNode["ProductName"].stringValue
                    let productID = jsonArrayNode["ProductID"].intValue
                    let productDescription = jsonArrayNode["ProductDescription"].stringValue
                    
                    
                    do {
                        let entity = NSEntityDescription.insertNewObjectForEntityForName("ProductEntity", inManagedObjectContext: self.managedObjectContext) as! ProductEntity
                        
                        entity.setValue(productID, forKey: "productID")
                        entity.setValue(productName, forKey: "productName")
                        entity.setValue(productDescription, forKey: "productDescription")
                        
                        try self.managedObjectContext.save()
                        
                    } catch {
                        fatalError("Failure to save context: \(error)")
                    }
                }
                completionHandler(true)
            }
            else{
                completionHandler(false)
            }
            
        }
    }
    
    func deleteAllData()
    {
        let productFetch = NSFetchRequest(entityName: "ProductEntity")
        do{
            let entity = try managedObjectContext.executeFetchRequest(productFetch) as! [ProductEntity]
            for product in entity{
                managedObjectContext.deleteObject(product)
            }
            try managedObjectContext.save()
        }catch{
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
