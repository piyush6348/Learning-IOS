//
//  ViewController.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 02/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit
import SwiftyJSON
class MovieViewController: UITableViewController, NetworkOperationsDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        performSearch()
    }
    
    func performSearch(){
        var ops = NetworkOps()
        ops.getData(searchTitle: "man", delegate: self)
    }
    
    //MARK: - Network Delegates
    
    func obtainedResult(json: JSON) {
        print("VC result")
        print(json)
    }
    
    func obtainedError(error: Error) {
        print("VC Error")
        print(error)
    }
    
}

