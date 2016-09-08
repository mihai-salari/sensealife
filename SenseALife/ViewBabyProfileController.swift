//
//  EditBabyProfileController.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 1/9/16.
//  Copyright © 2016 BouZeidan. All rights reserved.
//

import UIKit

class ViewBabyProfileController: UIViewController {
    
    @IBOutlet var FirstName: UILabel! //This IBOutlet holds the fisrt name of the baby
    @IBOutlet var LastName: UILabel! //This IBOutlet holds the last name of the baby
    @IBOutlet var SensorID: UILabel! //This IBOutler holds the senso ID to which this profile is tied to

    @IBOutlet var DisplayImage: UIImageView! //This IBOutlet is designed to hold the image of the baby
    
    var BabyProfileObject: BabyProfile! //This variable contains the baby profile information which is set from the ProfileController prior to the segue action
    var ProfileID: String = "" //This variable contains the baby profile ID
    
    let bpSegueIdentifier = "EditProfileSegue" //This constant contains the name of the segue to the View Baby Profile controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.FirstName.text = BabyProfileObject.FirstName
        self.LastName.text = BabyProfileObject.LastName
        self.SensorID.text = BabyProfileObject.SensorID
        self.DisplayImage.image = UIImage(data: BabyProfileObject.Picture)
        //self.ProfileID = BabyProfileObject.BabyProfileID!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function is designed in order to be executed prior to the segue being performed. In this function
    //actions such as setting values to properties on the destination controller can be performed.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == bpSegueIdentifier {
            if let destination = segue.destinationViewController as? SaveBabyProfileController {
                destination.BabyProfileObject = self.BabyProfileObject
                destination.Action = SaveBabyProfileController.ActionMethod.Edit
                //destination.BabyProfileObject.BabyProfileID = self.ProfileID
            }
        }
    }
}