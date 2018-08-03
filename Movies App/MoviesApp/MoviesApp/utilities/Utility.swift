//
//  Utility.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 03/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import Foundation


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
