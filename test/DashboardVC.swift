//
//  DashboardVC.swift
//  test
//
//  Created by Kimate Richards on 3/14/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class DashboardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var collection: UICollectionView!
     @IBOutlet weak var searchBar: UISearchBar!

    let managedObjectContext = DataController().managedObjectContext
    let url = "\(URL_BASE)\(URL_LOCATION_CONTROLLER)"


    var fetchedLocation = [SWLocation]()
    var location: SWLocation!

    var inSearchmode = false
    var filteredLocations = [SWLocation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if online
        self.deleteAllData()
        
        downloadLocation(){ completion in
            if completion {
                self.loadLocations()
            }
        }
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LocationCell", forIndexPath: indexPath) as? LocationCell{
            
            var location: SWLocation!
            if inSearchmode{
                location = filteredLocations[indexPath.row]
            }else{
                 location = self.fetchedLocation[indexPath.row]
            }

            cell.configureLocationCell(location)
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let location: SWLocation!
        if inSearchmode{
            location = filteredLocations[indexPath.row]
        }else{
                location = self.fetchedLocation[indexPath.row]
        }
        performSegueWithIdentifier("LocationDetailVC", sender: location)
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
    }
    func loadLocations(){
        let locationFetch = NSFetchRequest(entityName: "LocationEntity")
        do{
            
            fetchedLocation = try managedObjectContext.executeFetchRequest(locationFetch) as! [SWLocation]
            for location in fetchedLocation{
                if let locationName = location.valueForKey("locationName"),
                let locationID = location.valueForKey("locationID"),
                    let imageURL = location.valueForKey("imageURL"){
                print("\(locationID) \(locationName) \(imageURL)")
                }
            }
            collection.reloadData()
        }catch{
            fatalError("ooooo \(error)")
        }
    }
    
    func deleteAllData()
    {
        let locationFetch = NSFetchRequest(entityName: "LocationEntity")
        do{
        let entity = try managedObjectContext.executeFetchRequest(locationFetch) as! [SWLocation]
        for location in entity{
            managedObjectContext.deleteObject(location)
        }
        try managedObjectContext.save()
        }catch{
            print(error)
        }
    }
    
    func downloadLocation(completionHandler:(Bool) -> ()){
        let locationURL = NSURL(string: "\(URL_BASE)location/getlocations/")!
        let parameters = [
            "ServiceProvider": SERVICE_PROVIDER
        ]
        Alamofire.request(.GET, locationURL, parameters: parameters).responseJSON {
            response in
            let result = response.result
            if result.isSuccess
            {
                let json = JSON(response.result.value!)
                for jsonArrayNode in json.array!
                {
                    let locationName = jsonArrayNode["LocationName"].stringValue
                    let locationID = jsonArrayNode["LocationID"].intValue
                    let imageURL = jsonArrayNode["ImageURL"].stringValue
       

                        do {
                                let entity = NSEntityDescription.insertNewObjectForEntityForName("LocationEntity", inManagedObjectContext: self.managedObjectContext) as! SWLocation

                            entity.setValue(locationID, forKey: "locationID")
                            entity.setValue(locationName, forKey: "locationName")
                            entity.setValue(imageURL, forKey: "imageURL")
                            
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
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchmode = false
            collection.reloadData()
            view.endEditing(true)
        }else{
            inSearchmode = true
            let lower = searchBar.text!.lowercaseString
            filteredLocations = fetchedLocation.filter({$0.locationName.lowercaseString.rangeOfString(lower) != nil})
            collection.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LocationDetailVC"{
            if let detailsVC = segue.destinationViewController as? LocationDetailVC{
                if let locate = sender as? SWLocation{
                    detailsVC.location = locate
                }
            }
        }
    }
}
