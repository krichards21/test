

import UIKit
import Alamofire
import CoreData
import SwiftyJSON

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.borderColor = UIColor.blackColor().CGColor
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.cornerRadius = 5
            }

    var UserID: Int = 0
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func btnLogin(sender: AnyObject) {
        errorLbl.text = ""
        if (txtUsername.text == "")
        {
            errorLbl.text = "Username is invalid"
        }
        
        if (txtPassword.text == "")
        {
            errorLbl.text = "Password is invalid"
        }
        
        if (errorLbl.text == "")
        {
            //login(){ completion in
                //if completion {
                    let homeController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeController") as! HomeController
                    //homeController.userID = self.UserID
            homeController.userID = 1
                    self.presentViewController(homeController, animated: false, completion: nil)
                //}
            //}
            
        }
        
    }
    
    func login(completionHandler:(Bool) -> ()){
        let loginURL = NSURL(string: "\(URL_BASE)users/loginuser/")!
        let username = txtUsername.text
        let password = txtPassword.text
        let parameters: [String: AnyObject] = [
            "email": username!,
            "password": password!
        ]
        Alamofire.request(.POST, loginURL, parameters: parameters).responseJSON {
            response in
            let result = response.result
            if result.isSuccess
            {
                let json = JSON(response.result.value!)
                for jsonArrayNode in json.array!
                {
                    self.UserID = jsonArrayNode["UserID"].intValue

                    
                }
                completionHandler(true)
            }
            else{
                completionHandler(false)
            }
            
        }
    }

   }

