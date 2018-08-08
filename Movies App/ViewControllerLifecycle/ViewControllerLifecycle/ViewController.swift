//
//  ViewController.swift
//  ViewControllerLifecycle
//
//  Created by Piyush Gupta on 08/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("viewDidLoad")
//         performSegue(withIdentifier: "secondScreen", sender: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisAppear")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue")
    }
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
}

