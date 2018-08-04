//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 03/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit
import SwiftyJSON

let jsonMApping: [Int: String] = [
    0:"Title",
    1:"Year",
    2:"Rated",
    3:"Released",
    10:"Plot"
]
class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "movieCell"
    var imdbID: String?{
        didSet{
            // perform network call
            print("imdb id obtained " + imdbID!)
            performSearch(movieIDToSearchFor: imdbID!)
        }
    }
    var json: JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonMApping.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MoviewDetailsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MoviewDetailsTableViewCell
        
        cell.label1?.text = jsonMApping[indexPath.row]
        //cell.label2?.text = (json![jsonMApping[indexPath.row]!]).stringValue
        return cell
    }
    
    //MARK: - Network Call
    func performSearch(movieIDToSearchFor: String){
        let ops = NetworkOps()
        //ops.getData(searchTitle: "man", delegate: self)
        ops.getData(byId: true, imdbID: movieIDToSearchFor, completion: { (data, response, error) in
            if(error != nil){
                print(error!)
            }else{
                if let dataFetched = data {
                    let responseObtained = response as? HTTPURLResponse
                    if(responseObtained?.statusCode == 200){
                        self.jsonParsing(obtainedData: dataFetched)
                        print("Second screen data obtained")
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        })
    }
    
    //MARK: - JSON Handling
    func jsonParsing(obtainedData: Data){
        json = JSON(obtainedData)
        print(json!)
        
        var movieDetail = MovieItem(context: self.context)
        movieDetail.plot = json!["Plot"].stringValue
        movieDetail.title = json!["Title"].stringValue
        movieDetail.poster = json!["Poster"].stringValue
        // Save data in db as well
        // call save data here
    }
}
