//
//  LocationDetailVC.swift
//  test
//
//  Created by Kimate Richards on 3/17/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit

class LocationDetailVC: UIViewController {
    var location: SWLocation!
    @IBOutlet weak var locationName: UILabel!

    override func viewDidLoad() {
    
        super.viewDidLoad()
        print(location.locationName)
        locationName.text = location.locationName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
