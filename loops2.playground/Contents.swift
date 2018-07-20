//: Playground - noun: a place where people can play

import UIKit

var numBottles: Int = 99

func decNumBottles(numBottlesVal: inout Int) -> Int{
    print("\(numBottles) of beer on the wall")
    numBottlesVal -= 1
    print("Take one down Pass it around, you got \(numBottlesVal) left")
    return numBottlesVal
}
var ct: Int = 1

print("...........................................")
while ( ct == 1 ){
    if ( numBottles == 1 ){
        numBottles = decNumBottles(numBottlesVal: &numBottles)
        numBottles = 99
        ct = 0;
    }
    else{
        numBottles = decNumBottles(numBottlesVal: &numBottles)
    }
}
