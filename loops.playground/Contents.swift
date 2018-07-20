//: Playground - noun: a place where people can play

import UIKit

var arr = [1,3,4,6,7,0]

// printing all elements of array
for i in arr{
    print (i)
}

// print from 1 to 10(inclusive)
for i in 1...10 {
    print(i)
}

// print from 1 to 10(exclusive)
for i in 1..<10 {
    print(i)
}

for i in 1...10 where i % 2 == 0{
    print(i * 10)
}
