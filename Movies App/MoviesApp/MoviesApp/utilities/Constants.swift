//
//  Constants.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 02/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import Foundation

class Constants {
    static let OMDB_BASE_URL = "http://www.omdbapi.com"
    static let OMDB_API_KEY = "f8e74142"
    static let PARAM_TITLE = "t"
    static let PARAM_API_KEY = "apikey"
    static let PARAM_STRING = "s"
    static let PARAM_ID = "i"
    static let TYPE_MOVIE = 1
    static let TYPE_SERIES = 2
    static let TYPE_EPISODE = 3
    
    // JSON PARSING CNSTS
    static let SEARCH_KEY = "Search"
    static let TITLE_KEY = "Title"
    static let IMDB_ID_KEY = "imdbID"
    static let TYPE_KEY = "Type"
    static let YEAR_KEY = "Year"
    static let POSTER_KEY = "Poster"
}
