

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.borderColor = UIColor.blackColor().CGColor
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.cornerRadius = 5
            }

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func btnLogin(sender: AnyObject) {
        
    }

   }

