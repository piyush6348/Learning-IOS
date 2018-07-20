//: Playground - noun: a place where people can play

//var str = "Hello, playground"
//
//var val: Int = 10
//
//var msg: String = "Hi"
//print(msg)
//

func printAll(numberOfCartons: Int){
    print("Hi")
    print("abc \(numberOfCartons)")
    print("efgh")
    print("ijkl")
    print(String(numberOfCartons))
    
    let priceToPay = numberOfCartons * 10
    print("price to pay is $\(priceToPay)")
}

printAll(numberOfCartons: 90)
