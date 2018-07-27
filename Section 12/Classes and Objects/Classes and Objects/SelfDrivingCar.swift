//
//  SelfDrivingCar.swift
//  Classes and Objects
//
//  Created by Piyush Gupta on 27/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import Foundation

class SelfDrivingCarClass: Car {
    var destination: String = " Some destination "
    
    override init() {
        //super.init()
        print("SelfDrivingCar initializer")
    }
    override func drive() {
        super.drive()
        print("Driving to " + destination)
        //super.drive()
    }
    override func xyz(){
        print("Car xyz func called")
    }
}
