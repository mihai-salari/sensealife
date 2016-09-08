//
//  FirstViewController.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 12/20/15.
//  Copyright © 2015 BouZeidan. All rights reserved.
//

import UIKit
import CoreBluetooth

class DashboardController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    @IBOutlet var alertLabel: UILabel!
    @IBOutlet var alertImage: UIImageView!
    @IBOutlet var Logger: UITextView! //This IBOutlet is designed in order to hold the logs for the
    @IBOutlet var gasStationImage: UIButton!


    
    //This variable contains the logic which indicates whether a notification has been triggered
    private var parentNotified: Bool = false
    
    //This variable contains the time of the notification when it was sent to the parents
    private var timeOfNotification: NSDate = NSDate()
    
    // BLE
    var centralManager : CBCentralManager!
    var SenseALifePeripheral : CBPeripheral!
    
    let DeviceName = "HMSoft" //This is the device name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = -1
        
        self.alertImage.hidden = true
        self.alertLabel.hidden = true
        
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Check status of BLE hardware
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOn {
            // Scan for peripherals if BLE is turned on
            central.scanForPeripheralsWithServices(nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            //Logger.text = Logger.text + ("\nSearching for Sense-A-Life Device")
        }
        else {
            // Can have different conditions for all states if needed - print generic message for now
            //Logger.text = Logger.text + ("\nThe Sense-A-Life bluetooth switched off or not initialized")
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        let nameOfDeviceFound = (advertisementData as NSDictionary).objectForKey(CBAdvertisementDataLocalNameKey) as? NSString
        
        if (nameOfDeviceFound == self.DeviceName) {
            // Update Status Label
            //Logger.text = Logger.text + ("\nSense-A-Life sensor found.")
            
            // Stop scanning
            self.centralManager.stopScan()
            // Set as the peripheral to use and establish connection
            self.SenseALifePeripheral = peripheral
            self.SenseALifePeripheral.delegate = self
            self.centralManager.connectPeripheral(peripheral, options: nil)
        }
        else {
            //Logger.text = Logger.text + "\nSense-A-Life sensor not found."
        }
        
    }
    
    // Discover services of the peripheral
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        //Logger.text = Logger.text + ("\nDiscovering peripheral services")
        peripheral.discoverServices(nil)
    }
    
    // Check if the service discovered is a valid IR Temperature Service
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        //Logger.text = Logger.text + ("\nLooking at peripheral services")
        for service in peripheral.services! {
            let thisService = service as CBService
            
            if service.UUID.UUIDString == "FFE0" {
                // Discover characteristics of IR Temperature Service
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
        }
    }
    
    // Enable notification and sensor for each characteristic of valid service
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        
        // update status label
        //Logger.text = Logger.text + ("\nEnabling Sense-A-Life sensor...")
        
        // 0x01 data byte to enable sensor
        var enableValue = 1
        let enablyBytes = NSData(bytes: &enableValue, length: sizeof(UInt8))
        
        // check the uuid of each characteristic to find config and data characteristics
        for charateristic in service.characteristics! {
            let thisCharacteristic = charateristic as CBCharacteristic
            // check for data characteristic
            if thisCharacteristic.UUID.UUIDString == "FFE1" {
                // Enable Sensor Notification
                self.SenseALifePeripheral.setNotifyValue(true, forCharacteristic: thisCharacteristic)
                
                // Enable Sensor
                self.SenseALifePeripheral.writeValue(enablyBytes, forCharacteristic: thisCharacteristic, type: CBCharacteristicWriteType.WithResponse)
            }
        }
    }
    
    // Get data values when they are updated
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {

        if characteristic.UUID.UUIDString == "FFE1" {
            //Logger.text = Logger.text + "\n" + ((characteristic.value?.hexString())! as String)
            
            if(characteristic.isNotifying){
                //let command = NSString(data: (characteristic.value)!, encoding: NSUTF8StringEncoding)!
                
                //if(command == "ChildDetected"){
                    self.setNotificationSenseALife(5)
                    
                    self.alertImage.hidden = false
                    self.alertLabel.hidden = false
                    self.gasStationImage.hidden = false
                //}
            }
        }
    }
    
    // If disconnected, start searching again
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        //Logger.text = Logger.text + ("\nDisconnected Sense-A-Life sensor...")
        central.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //Logger.text = Logger.text + ("\nSense-A-Life sensor is ready for transmission...")
    }
    
    @IBAction func DelayForGas(sender: AnyObject) {
        self.setNotificationSenseALife(5)
        
        self.alertImage.hidden = false
        self.alertLabel.hidden = false
        self.gasStationImage.hidden = false
    }
    
    func setNotificationSenseALife(intervalSinceNow: Double){
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: intervalSinceNow)
        notification.alertBody = "BABY IS IN THE CAR SEAT!!!"
        notification.soundName = "baby_in_car_seat.caf"
        notification.applicationIconBadgeNumber = 1
        notification.category = "COUNTER_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func clearNotificationSenseALife(){
        self.alertImage.hidden = true
        self.alertLabel.hidden = true
        self.gasStationImage.hidden = true
        UIApplication.sharedApplication().applicationIconBadgeNumber = -1
    }
    
}

