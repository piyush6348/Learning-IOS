//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 03/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

let jsonMApping: [Int: String] = [
    0:"Title",
    1:"Year",
    2:"Rated",
    3:"Released",
    4:"Runtime",
    5:"Genre",
    6:"Plot",
    7:"Poster"
]
class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Don't forget to enter this in IB also
    var movieItemArray: [MovieItem] = [MovieItem]()
    var movieItemKeysArray: [String] = [String]()
    let cellReuseIdentifier = "movieCell"
    var imdbID: String?{
        didSet{
            // perform network call
            print("imdb id obtained " + imdbID!)
            
            if(MoviesApp.checkPresenceOfMovieItem(imdbID: imdbID!, context: context)){
                // fetch from db and show
                movieItemArray = MoviesApp.fetchMovieItemFromDb(imdbID: imdbID!, context: context)
                if(!view.isHidden){
                    loadAndConfig()
                }
            }else{
                performSearch(movieIDToSearchFor: imdbID!)
            }
        }
    }
    var json: JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadAndConfig()
    }
    
    func loadAndConfig() {
        tableView.reloadData()
        configTableView()
    }
    
    //MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("--------------------------------------------------------")
        print("movie item entity details")
        print(MovieItem.entity().attributesByName.keys)
        let tempDict = MovieItem.entity().attributesByName.keys
        movieItemKeysArray.removeAll()
        movieItemKeysArray = Array(tempDict)
//        for (key) in tempDict{
//            print(key)
//            movieItemKeysArray.append(key)
//        }
        return movieItemKeysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MoviewDetailsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MoviewDetailsTableViewCell
        
        let index = indexPath.row
        cell.label1?.text = movieItemKeysArray[index]
        if(movieItemArray.count > 0){
            //MovieItem.entity().dictionaryWithValues
            
            cell.label2?.text = movieItemArray[0].value(forKey: movieItemKeysArray[index]) as! String
            loadImageInImgView(posterPath: movieItemArray[0].poster!)
        }
        //cell.label2?.text = (json![jsonMApping[indexPath.row]!]).stringValue
        return cell
    }
    
    //MARK: - Network Call
    func performSearch(movieIDToSearchFor: String){
        let ops = NetworkOps()
        //ops.getData(searchTitle: "man", delegate: self)
        ops.getData(byId: true, imdbID: movieIDToSearchFor, completion: { (data, response, error) in
            if(error != nil){
                print("didn't get json")
                print(error!)
            }else{
                if let dataFetched = data {
                    let responseObtained = response as? HTTPURLResponse
                    if(responseObtained?.statusCode == 200){
                        self.jsonParsing(obtainedData: dataFetched)
                        print("Second screen data obtained")
                        DispatchQueue.main.async {
                            self.loadAndConfig()
                        }
                    }
                    else{
                        print("Wrong status code")
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
        //loadImageInImgView(posterPath: movieDetail.poster!)
        movieDetail.imdbID = imdbID
        movieItemArray.removeAll()
        movieItemArray.append(movieDetail)
        // Save data in db as well
        // call save data here
        MoviesApp.saveData(contextToBeSavedIn: context)
        DispatchQueue.main.async {
            self.loadAndConfig()
        }
    }
    func loadImageInImgView(posterPath: String){
        do{
            let url = try URL(string: posterPath)
            self.imgView.sd_setImage(with: url) { (image, error, cacheType, url) in
                if(error != nil){
                    print("Error in loading img \(error)")
                }
            }
        }catch{
            print("Wrong poster URL")
        }
    }
    //MARK: - Configure tableview
    func configTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
    }
}
