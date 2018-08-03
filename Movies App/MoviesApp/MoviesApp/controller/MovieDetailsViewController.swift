//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 03/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var imgViewPoster: UIImageView!
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
    var movieDetails: [MovieItem] = [MovieItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MoviewDetailsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MoviewDetailsTableViewCell
        
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
                        let fetchedMovieDetails = self.jsonParsing(obtainedData: dataFetched)
                        self.movieDetails = [fetchedMovieDetails]
                        print("Second screen data obtained")
                        print(fetchedMovieDetails)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        })
    }
    
    //MARK: - JSON Handling
    func jsonParsing(obtainedData: Data) -> MovieItem {
        let json = JSON(obtainedData)
        print(json)
        
        var movieDetail = MovieItem(context: self.context)
        movieDetail.plot = json["Plot"].stringValue
        movieDetail.title = json["Title"].stringValue
        movieDetail.poster = json["Poster"].stringValue
        return movieDetail
    }
}
