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
    var moviesArray: [MovieClass] = [MovieClass]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("xyz.txt")
    
    var clickedImdbID: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //performSearch()
        print(dataFilePath)
    }
    
    // MARK :- Core Data
    
    func saveData(reloadAsWell: Bool = true){
        do{
            try context.save()
        }catch{
            print("Error encoding data \(error)")
        }
        if(reloadAsWell){
            self.tableView.reloadData()
        }
    }
    
    func loadData(pred titlePredicate: NSPredicate? = nil){
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        let typePredicate = NSPredicate(format: "type MATCHES %@", "\(selectedType)")
        //let titlePredicate = NSPredicate(format: "title MATCHES %@", titleToLookFor)
        
        if let optionalPredicate = titlePredicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [optionalPredicate, typePredicate])
        }else{
            request.predicate = typePredicate
        }
        
        do{
            moviesArray = convertToMovieClassArray(movieArray: (try context.fetch(request)))
            tableView.reloadData()
        }catch{
            print("Error while loading data \(error)")
        }
    }
    func loadData(movieSearchedResult: [Movie]){
        moviesArray = convertToMovieClassArray(movieArray: movieSearchedResult)
        tableView.reloadData()
    }
    
    func checkPresenceOfMovie(imdbID: String) -> Bool {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "imdbID = %@", imdbID)
        
        do{
            let obtainedElem = try context.fetch(fetchRequest)
            print("Obtained element when checked for presence")
            print(obtainedElem)
            if(obtainedElem.count > 0){
                return true
            }
        }catch{
            print("Error while checking presence of data \(error)")
        }
        return false
    }
    
    func checkPresenceOfMovie(title: String) -> [Movie]? {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        
        do{
            let obtainedElem = try context.fetch(fetchRequest)
            return obtainedElem
        }catch{
            print("Error while checking presence of data \(error)")
        }
        return nil
    }
    
    func insertIntoCoreData(elem movie: MovieClass) {
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: self.context)
        let newMovie = NSManagedObject(entity: entity!, insertInto: self.context)
        newMovie.setValue(movie.imdbID, forKey: "imdbID")
        newMovie.setValue(movie.poster, forKey: "poster")
        newMovie.setValue(movie.title, forKey: "title")
        newMovie.setValue(movie.type, forKey: "type")
        newMovie.setValue(movie.year, forKey: "year")
        self.saveData(reloadAsWell: false)
    }
    //MARK: - Table View Data Source methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let movie = moviesArray[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    //MARK: - Table View Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesArray[indexPath.row]
        print(movie)
        if(!checkPresenceOfMovie(imdbID: movie.imdbID)){
            // add current or clicked movie to 1st table
            // fetch data from 2nd api and show on 2nd screen
            print("not found")
            self.insertIntoCoreData(elem: movie)
            performSegue(withIdentifier: "movieDetails", sender: self)
            // perform segue 
        }
        else{
            // movie present
            print("found")
            performSegue(withIdentifier: "movieDetails", sender: self)
        }
    }
    
    //MARK: - Before Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "movieDetails"){
            let destinationVC = segue.destination as! MovieDetailsViewController
            print(tableView.indexPathForSelectedRow?.row)
            print(moviesArray[(tableView.indexPathForSelectedRow?.row)!].imdbID)
            destinationVC.imdbID = moviesArray[(tableView.indexPathForSelectedRow?.row)!].imdbID
        }
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
    func jsonParsing(obtainedData: Data) -> [MovieClass] {
        let json = JSON(obtainedData)
        print(json)
        
        if let searchArray = (json[Constants.SEARCH_KEY].array){
            var fetchedMovieArray :[MovieClass] = [MovieClass]()
            print("fetched array")
            for movie in searchArray{
                print(movie)
                var elem = MovieClass()
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
        return [MovieClass]()
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
            let check = self.checkPresenceOfMovie(title: searchBar.text!)
            
            if let res = check{
                if (res.count > 0){
                    loadData(movieSearchedResult: res)
                }
                else{
                    self.performSearch(movieTitleToSearchFor: searchBar.text!)
                    DispatchQueue.main.async {
                        searchBar.resignFirstResponder()
                    }
                }
            }
            else{
                self.performSearch(movieTitleToSearchFor: searchBar.text!)
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        loadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count == 0){
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

