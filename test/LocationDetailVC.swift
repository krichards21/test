//
//  LocationDetailVC.swift
//  test
//
//  Created by Kimate Richards on 3/17/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit

class LocationDetailVC: UIViewController {
    @IBOutlet weak var dateTxt: UITextField!
    var location: SWLocation!
    @IBOutlet weak var locationName: UILabel!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        locationName.text = location.locationName
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        let currentDate = NSDate()
        dateTxt.text = dateFormatter.stringFromDate(currentDate)
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
        dateTxt.text = dateFormatter.stringFromDate(sender.date)
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
