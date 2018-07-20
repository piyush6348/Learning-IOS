//: Playground - noun: a place where people can play

//var str = "Hello, playground"
//
//var val: Int = 10
//
//var msg: String = "Hi"
//print(msg)
//
import UIKit

func printAll(numberOfCartons: Int){
    print("Hi")
    print("abc \(numberOfCartons)")
    print("efgh")
    print("ijkl")
    print(String(numberOfCartons))
    
    let priceToPay = numberOfCartons * 10
    print("price to pay is $\(priceToPay)")
}


func fun2(yourName: String, theirName: String) -> Int{
    let lovVal = arc4random_uniform(101)
    
    if lovVal > 80 {
        print("Wow")
    }
    else if lovVal >= 40 && lovVal <= 80 {
        print("Okay")
    }
    else{
        print("No")
    }
    return Int(lovVal)
}

func bmiCalculator(mass: Double, height: Double)-> Double{
    var bmi: Double = 0.0
    bmi = mass/(height * height)
    
    if bmi > 25{
        print("OverWeight")
    }
    else if bmi >= 18.5 && bmi < 25{
        print("Normal Weight")
    }
    else if bmi < 18.5{
        print("Underweight")
    }
    return bmi
}




printAll(numberOfCartons: 90)
print("\(fun2(yourName: "Piyush", theirName: "Piyush"))")
print(bmiCalculator(mass: 83, height: 6))
