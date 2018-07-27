//
//  Car.swift
//  Classes and Objects
//
//  Created by Piyush Gupta on 26/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import Foundation

enum CarType {
    case Hatchback
    case Sedan
    case Coupe
}
class Car{
    var colour: String
    var numberOfSeats: Int
    var carType: CarType 
    
    // constructor
    init() {
        colour = "Black"
        numberOfSeats = 5
        carType = .Coupe
        print("Car constructor called")
    }
    
    convenience init(customerChosenColor: String){
        self.init()
        self.colour = customerChosenColor
    }
    
    func drive() {
        print("Car is moving")
    }
    
    func xyz(){
        print("xyz child class called")
    }
}
