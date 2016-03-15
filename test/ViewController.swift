

import UIKit
import Alamofire

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
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                
                    if let dict = json[0] as? Dictionary<String, AnyObject>{
                        if let locationName = dict["LocationName"] as? String,
                            let locationID = dict["LocationID"] as? Int,
                        let address3 = dict["Address3"] as? String,
                            let address2 = dict["Address2"] as? String,
                            let address1 = dict["Address1"] as? String,
                            let city = dict["City"] as? String,
                            let state = dict["State"] as? String,
                            let postalCode = dict["PostalCode"] as?String,
                            let hoursStart = dict["HourStart"] as? String,
                            let hoursEnd = dict["HourEnd"] as? String,
                            let daysOpen = dict["DaysOpen"] as? String,
                            let googleMapsSmall = dict["GoogleMapSmall"] as? String,
                            let googleMapsMedium = dict["GoogleMapMedium"] as? String,
                            let imageUrl = dict["ImageURL"] as? String{
                            
                            let location = SWLocation(locationName: locationName,
                                address1: address1, address2: address2, address3: address3, city: city, state: state, postalCode: postalCode, locationID: locationID, googleMapsSmall: googleMapsSmall, googleMapsMedium: googleMapsMedium, hoursStart: hoursStart, hoursEnd: hoursEnd, daysOpen: daysOpen, imageURL: imageUrl)
                            
                            print(location.locationName)
                        }
                    }
                    
                    //print(json)
                } catch let myError {
                    print("error: \(myError)")
                }
            }
        }.resume()

    }


    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func btnLogin(sender: AnyObject) {
        
    }
}

