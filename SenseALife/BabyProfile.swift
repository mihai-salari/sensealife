//
//  Baby.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 12/25/15.
//  Copyright © 2015 BouZeidan. All rights reserved.
//

import CoreData
import Foundation
import UIKit

public class BabyProfile{
    var BabyProfileID: String?
    var FirstName: String?
    var LastName: String?
    var Picture: NSData
    var SensorID: String?
    
    init() {
        self.Picture = NSData()
    }
    
    //This function is designed in order to validate the model (Baby Profile).
    //A true logic is returned if an only if conditions are not satisfied; otherwise,
    //if some or all conditions are met then the model is not considered valid.
    internal func ValidateModel() -> Bool{
        
        var valid: Bool = true
        
        if (self.FirstName?.isEmpty == true){
            valid = false
        }
        
        if (self.LastName?.isEmpty == true){
            valid = false
        }
        
        if (self.Picture.length == 0){
            valid = false
        }
        
        if (self.SensorID?.isEmpty == true){
            valid = false
        }
        
        return valid
    }
    
    //This function is designed in order to map a record returned from Data Core to a Baby Profile object.
    internal func Map(data:[AnyObject])-> BabyProfile{
        
        let babyProfile = BabyProfile()
        
        if(data.count > 0){
            
            babyProfile.BabyProfileID = data[0].valueForKey("babyProfileID") as? String
            babyProfile.FirstName = data[0].valueForKey("firstName") as? String
            babyProfile.LastName = data[0].valueForKey("lastName") as? String
            
            if(data[0].valueForKey("picture") == nil){
                babyProfile.Picture  = UIImagePNGRepresentation(UIImage(imageLiteral: "DefaultBabyPicture.png"))!
            }else{
                babyProfile.Picture = (data[0].valueForKey("picture") as? NSData)!
            }
            babyProfile.SensorID = data[0].valueForKey("sensorID") as? String
        }
        
        return babyProfile
    }
    
    //This function is designed in order to map the data returned from core data to a list of BabyProfile
    internal func MapToList(data:[AnyObject])->[BabyProfile]{
        var profiles = [BabyProfile]()
        var babyProfile: BabyProfile = BabyProfile()
        
        for(var i = 0; i < data.count; i++){
            babyProfile = BabyProfile()
            
            babyProfile.BabyProfileID = data[i].valueForKey("babyProfileID") as? String
            babyProfile.FirstName = data[i].valueForKey("firstName") as? String
            babyProfile.LastName = data[i].valueForKey("lastName") as? String
            
            if(data[i].valueForKey("picture") == nil){
                babyProfile.Picture  = UIImagePNGRepresentation(UIImage(imageLiteral: "DefaultBabyPicture.png"))!
            }else{
                babyProfile.Picture = (data[i].valueForKey("picture") as? NSData)!
            }
            babyProfile.SensorID = data[i].valueForKey("sensorID") as? String
            
            if(babyProfile.FirstName == nil || babyProfile.LastName == nil){
                continue
            }
            
            profiles.append(babyProfile)
        }
        
        return profiles
    }
}