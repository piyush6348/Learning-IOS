//: Playground - noun: a place where people can play

import UIKit


func calculator(a: Int, b:Int, operation: (Int,Int)->Int) -> Int{
    return operation(a,b)
}

func add(a:Int, b:Int) ->Int{
    return a+b
}

func multiply(a: Int, b:Int) -> Int{
    return a*b
}


calculator(a: 4, b: 5, operation: add(a:b:))
calculator(a: 4, b: 5, operation: multiply(a:b:))


func addOne(n: Int)-> Int{
    return (n+1)
}

var array = [1,2,3,4,5]
array.map(addOne)
