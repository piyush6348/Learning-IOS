//
//  ViewController.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 02/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

let types = ["movie","series","episode"]
let movieTypeMap: [String:Int16] = ["movie": 0, "series":1, "episode":2]
class MovieViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedType: Int = 0
    var moviesArray: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //performSearch()
    }
    
    // MARK :- Core Data
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error encoding data \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData(pred titlePredicate: NSPredicate? = nil){
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        let typePredicate = NSPredicate(format: "type MATCHES %@", types[selectedType])
        //let titlePredicate = NSPredicate(format: "title MATCHES %@", titleToLookFor)
        
        if let optionalPredicate = titlePredicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [optionalPredicate, typePredicate])
        }else{
            request.predicate = typePredicate
        }
        
        do{
            moviesArray = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print("Error while loading data \(error)")
        }
    }
    
    func saveAndLoad(titleSearched: String){
        saveData()
        let titlePredicate = NSPredicate(format: "title MATCHES %@", titleSearched)
        loadData(pred: titlePredicate)
    }
    
    func checkPresenceOfMovie(imdbID: String) -> Bool {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "imdbID = %@", imdbID)
        
        do{
            let obtainedElem = try context.fetch(fetchRequest)
            if(obtainedElem.count > 0){
                return true
            }
        }catch{
            print("Error while checking presence of data \(error)")
        }
        return false
    }
    
    //MARK: - Table View Data Source methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let movie = moviesArray[indexPath.row]
        cell.textLabel?.text = movie.title!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    //MARK: - Table View Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesArray[indexPath.row]
        
    }
    //MARK: - Network Call
    func performSearch(movieTitleToSearchFor: String){
        let ops = NetworkOps()
        //ops.getData(searchTitle: "man", delegate: self)
        ops.getData(searchTitle: movieTitleToSearchFor) { (data, response, error) in
            if(error != nil){
                print(error!)
            }else{
                if let dataFetched = data {
                    let responseObtained = response as? HTTPURLResponse
                    if(responseObtained?.statusCode == 200){
                        let fetchedMoviesArray = self.jsonParsing(obtainedData: dataFetched)
                        self.moviesArray = fetchedMoviesArray
                        print(fetchedMoviesArray)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - JSON Handling
    func jsonParsing(obtainedData: Data) -> [Movie] {
        let json = JSON(obtainedData)
        print(json)
        
        if let searchArray = (json[Constants.SEARCH_KEY].array){
            var fetchedMovieArray :[Movie] = [Movie]()
            print("fetched array")
            for movie in searchArray{
                print(movie)
                var elem = Movie(context: self.context)
                elem.title = movie[Constants.TITLE_KEY].stringValue
                elem.imdbID = movie[Constants.IMDB_ID_KEY].stringValue
                elem.poster = movie[Constants.POSTER_KEY].stringValue
                elem.type = movieTypeMap[(movie[Constants.TYPE_KEY].stringValue)]!
                elem.year = movie[Constants.YEAR_KEY].stringValue
                fetchedMovieArray.append(elem)
            }
            print(fetchedMovieArray)
            return fetchedMovieArray
        }
        print("fetched not array")
        return [Movie]()
    }
}

//MARK: - Search Operations
extension MovieViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // If clicked then look into local db
        // if found then show it otherwise
        // fetch from server show all possible
        // the one on which it is clicked is added to db
        if((searchBar.text?.count)! > 0){
            let titlePredicate = NSPredicate(format: "title MATCHES %@", searchBar.text!)
            loadData(pred: titlePredicate)
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            let countOfRows = tableView.numberOfRows(inSection: 0)
            if(countOfRows == 0){
                // do API call
                self.performSearch(movieTitleToSearchFor: searchBar.text!)
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        loadData()
    }
}

