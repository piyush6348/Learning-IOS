//
//  Utility.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 03/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import Foundation
import CoreData

func convertToMovieClassArray(movieArray: [Movie]) -> [MovieClass]{
    var ans: [MovieClass] = [MovieClass]()
    for movie in movieArray{
        var movieClassObj = MovieClass()
        movieClassObj.imdbID = movie.imdbID!
        movieClassObj.poster = movie.poster!
        movieClassObj.title = movie.title!
        movieClassObj.type = movie.type
        movieClassObj.year = movie.year!
        
        ans.append(movieClassObj)
    }
    return ans
}

func checkPresenceOfMovie(imdbID: String, context: NSManagedObjectContext) -> Bool {
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

func checkPresenceOfMovieItem(imdbID: String, context: NSManagedObjectContext) -> Bool {
    let fetchRequest: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
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

func fetchMovieItemFromDb(imdbID: String, context: NSManagedObjectContext) -> [MovieItem] {
    let fetchRequest: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "imdbID = %@", imdbID)
    do{
        let obtainedElem = try context.fetch(fetchRequest)
        return obtainedElem
    }catch{
        print("Error while checking presence of data \(error)")
    }
    return [MovieItem]()
}

//MARK: - Core Data

func saveData(reloadAsWell: Bool = true, contextToBeSavedIn context: NSManagedObjectContext){
    do{
        try context.save()
    }catch{
        print("Error encoding data \(error)")
    }
    if(reloadAsWell){
        //self.tableView.reloadData()
    }
}
