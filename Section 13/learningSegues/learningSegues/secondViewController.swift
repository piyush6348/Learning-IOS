//
//  secondViewController.swift
//  learningSegues
//
//  Created by Piyush Gupta on 29/07/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit

protocol moveToSecond {
    func sendDataBack(data: String)
}
class secondViewController: UIViewController {
    
    @IBOutlet weak var secondVCText: UITextField!
    @IBOutlet weak var secondVCLabel: UILabel!
    
    var dataReceivedFromBack: String?
    var delegate: moveToSecond?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        secondVCLabel.text = dataReceivedFromBack!
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

    @IBAction func secondVCBackButtonClicked(_ sender: UIButton) {
        delegate?.sendDataBack(data: secondVCText.text!)
        self.dismiss(animated: true, completion: nil)
    }
}
