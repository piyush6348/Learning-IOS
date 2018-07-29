//
//  ViewController.swift
//  Segues
//
//  Created by Piyush Gupta on 28/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        // goToSecondScreen is identifier of this segue
        performSegue(withIdentifier: "goToSecondScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "goToSecondScreen"){
            
            let nextVC = segue.destination as! SecondViewController
            nextVC.passedData = textField.text
        }
    }
}

