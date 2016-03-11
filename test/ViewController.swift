

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://dmlm.azurewebsites.net/location/getlocations/"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)
        
        session.dataTaskWithURL(url!){
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseData = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments)
                    print(json)
                } catch {
                    print("Could not serialize")
                }
            }
        }.resume()

    }


    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func btnLogin(sender: AnyObject) {
        
    }
}

