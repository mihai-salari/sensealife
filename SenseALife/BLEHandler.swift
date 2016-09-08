//
//  BLEHandler.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 1/12/16.
//  Copyright © 2016 BouZeidan. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEHandler: NSObject, CBCentralManagerDelegate{
    override init(){
        super.init()
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager){
        switch(central.state){
            case .Unsupported:
                print("BLE is unsuported")
        case .PoweredOn:
                central.scanForPeripheralsWithServices(nil, options: nil)
            default:
                print("BLE default.")
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("\(peripheral.name) : \(RSSI) dBm")
    }
}