//
//  DashboardVC.swift
//  test
//
//  Created by Kimate Richards on 3/14/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit
import CoreData

class DashboardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var collection: UICollectionView!
     @IBOutlet weak var searchBar: UISearchBar!

    let managedObjectContext = DataController().managedObjectContext


    var fetchedLocation = [SWLocation]()
    var inSearchmode = false
    var filteredLocations = [SWLocation]()
    override func viewDidLoad() {
        super.viewDidLoad()

        createLoction()
        loadLocations()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LocationCell", forIndexPath: indexPath) as? LocationCell{
            
            let location: SWLocation!
            if inSearchmode{
                location = filteredLocations[indexPath.row]
            }else{
                location = fetchedLocation[indexPath.row]
            }
        
            cell.configureLocationCell(location)
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchmode{
            return filteredLocations.count
        }
        return fetchedLocation.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 120)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collection.reloadData()
    }
    func loadLocations(){
        let locationFetch = NSFetchRequest(entityName: "LocationEntity")
        
        do{
            fetchedLocation = try managedObjectContext.executeFetchRequest(locationFetch) as! [SWLocation]
            print(fetchedLocation.first!.locationID)
        }catch{
            fatalError("ooooo \(error)")
        }
    }
    func createLoction(){
        // need to add in a check on the latest data from the service
        let urlString = "http://dmlm.azurewebsites.net/location/getlocations/"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)
        for entity in self.fetchedLocation{
            self.managedObjectContext.deleteObject(entity)
        }
        
        session.dataTaskWithURL(url!){
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseData = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    
                    for var jsonArrayNode = 0; jsonArrayNode < json.count; jsonArrayNode++
                    {
                        if let dict = json[jsonArrayNode] as? Dictionary<String, AnyObject>{
                            if let locationName = dict["LocationName"] as? String,
                                let locationID = dict["LocationID"] as? Int,
                                //                                let address3 = dict["Address3"] as? String,
                                //                                let address2 = dict["Address2"] as? String,
                                //                                let address1 = dict["Address1"] as? String,
                                //                                let city = dict["City"] as? String,
                                //                                let state = dict["State"] as? String,
                                //                                let postalCode = dict["PostalCode"] as?String,
                                //                                let hoursStart = dict["HourStart"] as? String,
                                //                                let hoursEnd = dict["HourEnd"] as? String,
                                //                                let daysOpen = dict["DaysOpen"] as? String,
                                //                                let googleMapsSmall = dict["GoogleMapSmall"] as? String,
                                //                                let googleMapsMedium = dict["GoogleMapMedium"] as? String,
                                let imageUrl = dict["ImageURL"] as? String{

                                    
                                    let entity = NSEntityDescription.insertNewObjectForEntityForName("LocationEntity", inManagedObjectContext: self.managedObjectContext) as! SWLocation
                                    
                                    entity.setValue(locationName, forKey: "locationName")
                                    entity.setValue(locationID, forKey: "locationID")
                                    entity.setValue(imageUrl, forKey: "imageURL")
                                    
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        fatalError("Failure to save context: \(error)")
                                    }
                            }
                        }
                        
                    }
                    
                    //print(json)
                } catch let myError {
                    print("error: \(myError)")
                }
            }
            }.resume()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchmode = false
            collection.reloadData()
        }else{
            inSearchmode = true
            let lower = searchBar.text!.lowercaseString
            filteredLocations = fetchedLocation.filter({$0.locationName.lowercaseString.rangeOfString(lower) != nil})
            collection.reloadData()
        }
    }
}
