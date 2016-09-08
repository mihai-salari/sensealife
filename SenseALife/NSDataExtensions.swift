//
//  NSDataExtensions.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 1/31/16.
//  Copyright © 2016 BouZeidan. All rights reserved.
//

import Foundation
import UIKit

extension NSData {
    func hexString() -> NSString {
        let str = NSMutableString()
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
        for byte in bytes {
            str.appendFormat("%02hhx", byte)
        }
        return str
    }
}
