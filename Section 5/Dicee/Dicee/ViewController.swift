//
//  ViewController.swift
//  Dicee
//
//  Created by Piyush Gupta on 19/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgViewDice1: UIImageView!
    @IBOutlet weak var imgViewDIce2: UIImageView!
    
    var randomDiceVal1 : Int = 0
    var randomDiceVal2 : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnRoll(_ sender: UIButton) {
        
        // This random function returns unsignted int 32 hence type casted
        randomDiceVal1 = Int(arc4random_uniform(6))
        randomDiceVal2 = Int(arc4random_uniform(6))
        print(randomDiceVal1)
    }
}

