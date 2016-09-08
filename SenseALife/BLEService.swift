//
//  BLEService.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 1/12/16.
//  Copyright © 2016 BouZeidan. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEService{
    
    var centralManager: CBCentralManager!
    var bleHandler: BLEHandler
    
    init(){
        self.bleHandler = BLEHandler()
        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue: nil)
    }
}