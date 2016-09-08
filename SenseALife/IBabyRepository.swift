//
//  BabyRepository.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 12/25/15.
//  Copyright © 2015 BouZeidan. All rights reserved.
//

import Foundation

protocol IBabyRepository{
    
    //This function is designed in order to edit an existing baby profile.
    func EditBabyProfile(babyProfile:BabyProfile) throws -> Bool;
    
    //This repository function is designed in order to save a baby's profile into the
    //local database. The function accepts a Baby object which contains the baby's first
    //and last name as well as the baby's picture and the device that is binded to the app
    //which belongs to the respective baby's carseat.
    func SaveBabyProfile(babyProfile:BabyProfile) throws;
    
    //This repository function is designed in order to retrieve all of the baby profiles from the database.
    //The funcion will return the result as a BabyProfile array.
    func FetchBabyProfiles() throws -> [BabyProfile];
    
    //This function is designed in order to return a specific message from the property list.
    func GetVerbiage(propertyName:String) throws -> String;
}
