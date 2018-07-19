//
//  ViewController.swift
//  Magic 8 ball
//
//  Created by Piyush Gupta on 19/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var ballArray = ["ball1","ball2","ball3","ball4","ball5"]
    var ballRandomNumber: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            newBallImg()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnAsk(_ sender: UIButton) {
        newBallImg()
    }
    
    // overrided methods
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        newBallImg()
    }
    
    // dev defined functions
    func newBallImg(){
        ballRandomNumber = Int(arc4random_uniform(5))
        imgView.image = UIImage(named: ballArray[ballRandomNumber])
    }
}

