//
//  ViewController.swift
//  navigationdrawer
//
//  Created by Kimate Richards on 6/1/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sideBarButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SWRevealViewController *revealViewController = self.revealViewController;
        if (revealViewController) {
            [self.sidebarButton setTarget: self.revealViewController];
            [self.sidebarButton setAction: @selector(revealToggle:)];
            [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

