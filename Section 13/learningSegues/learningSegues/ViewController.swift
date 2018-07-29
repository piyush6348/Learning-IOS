//
//  ViewController.swift
//  learningSegues
//
//  Created by Piyush Gupta on 29/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, moveToSecond {

    @IBOutlet weak var firstVCLabel: UILabel!
    @IBOutlet weak var firstVCText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func firstVCBtnClick(_ sender: UIButton) {
        performSegue(withIdentifier: "moveToSecond", sender: self)
    }
    
    func sendDataBack(data: String) {
        firstVCLabel.text = data
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "moveToSecond"){
            let secondVC = segue.destination as! secondViewController
            secondVC.dataReceivedFromBack = firstVCText.text!
            secondVC.delegate = self
        }
    }
}

