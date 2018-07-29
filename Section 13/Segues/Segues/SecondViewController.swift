//
//  SecondViewController.swift
//  Segues
//
//  Created by Piyush Gupta on 28/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var uiLabel: UILabel!
    var passedData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        uiLabel.text = passedData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
