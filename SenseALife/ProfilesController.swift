//
//  SecondViewController.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 12/20/15.
//  Copyright © 2015 BouZeidan. All rights reserved.
//

import UIKit

class ProfilesController: UITableViewController {
    //This IBOutlet is designed to redirect the member to the Add/Edit Profile
    //View once clicked on it.
    @IBOutlet var AddProfileButton: UIBarButtonItem!
    @IBOutlet var BabyProfileTableView: UITableView! //This IBOutlet contains the list of all the baby profiles
    
    //This private repository contains a singleton object which contains functions that are
    //designed to handle normal operations such as saving a baby profile, fetching all baby 
    //profiles and so on.
    private var _babyProfileRepo: IBabyRepository = BabyRepository()
    private var _babyProfiles: [BabyProfile] = [BabyProfile]()
    
    let bpSegueIdentifier = "ViewProfileSegue" //This constant contains the name of the segue to the View Baby Profile controller
    let addBPSegueIdentifier = "AddBabyProfileSegue" //This constant contains the name of the segue to the Add Baby Profile controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            //var bleManager: BLEService!
            //bleManager = BLEService()
            
            //var babyProfile = BabyProfile()
            
            //babyProfile.FirstName = "Nadim"
            //babyProfile.LastName = "Bou Zeidan"
            //babyProfile.SensorID = "123-456-789-0000"
            
            //try _babyProfileRepo.SaveBabyProfile(babyProfile)
            
            //Call the repository in order to fetch all of the baby profiles that
            //are available in the local database on the phone.
            _babyProfiles = try _babyProfileRepo.FetchBabyProfiles()
        }catch{
            fatalError("Failed to fetch baby profiles from the database located on the phone. Error: \(error)")
        }
    }
    
    //This override function will get executed everytime the page is loaded regardless of whether the app was started or not.
    override func viewWillAppear(animated: Bool) {
        do{
            _babyProfiles = try _babyProfileRepo.FetchBabyProfiles()
            self.BabyProfileTableView.reloadData()
        }catch{
            fatalError("Failed to fetch baby profiles from the database located on the phone. Error: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._babyProfiles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("BabyProfileCell", forIndexPath: indexPath) as! BabyProfileTableCell
        
        var babyProfile: BabyProfile
        
        babyProfile = _babyProfiles[indexPath.row]
        
        cell.FullName.text = babyProfile.FirstName! + " " + babyProfile.LastName!
        cell.SensorID.text = babyProfile.SensorID
        cell.BabyImage.image = UIImage(data: babyProfile.Picture)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        BabyProfileTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //This function is designed in order to be executed prior to the segue being performed. In this function
    //actions such as setting values to properties on the destination controller can be performed.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == bpSegueIdentifier {
            if let destination = segue.destinationViewController as? ViewBabyProfileController {
                if let bpIndex = BabyProfileTableView.indexPathForSelectedRow?.row{
                    destination.BabyProfileObject = _babyProfiles[bpIndex]
                }
            }
        }else if segue.identifier == addBPSegueIdentifier{
            if let destination = segue.destinationViewController as? SaveBabyProfileController {
                destination.Action = SaveBabyProfileController.ActionMethod.Add
            }
        }
    }
}

