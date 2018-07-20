//: Playground - noun: a place where people can play

import UIKit

func fibonacci(n: Int) -> Int{
    if( n == -2 ){
        return 0
    }
    if( n == -1 ){
        return 1
    }
    let val = fibonacci(n: n-1) + fibonacci(n: n-2)
    return val
}

//fibonacci(n: 6)
var firstTerm: Int = 0
var secondTerm: Int = 1

let n: Int = 5

print(firstTerm)
print(secondTerm)

for _ in 1...5 {
    let thirdTerm: Int = firstTerm + secondTerm
    firstTerm = secondTerm
    secondTerm = thirdTerm
    print(thirdTerm)
}
