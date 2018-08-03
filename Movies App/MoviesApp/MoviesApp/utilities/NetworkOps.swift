//
//  NetworkOps.swift
//  MoviesApp
//
//  Created by Piyush Gupta on 02/08/18.
//  Copyright © 2018 Piyush Gupta. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkOps{
    
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    
    func getData(searchTitle: String="", byId: Bool = false,imdbID: String = "", completion: @escaping (Data?, URLResponse?, Error?) ->() ){
        print("function called")
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: Constants.OMDB_BASE_URL){
            if(byId){
                urlComponents.query = "\(Constants.PARAM_ID)=\(imdbID)&\(Constants.PARAM_API_KEY)=\(Constants.OMDB_API_KEY)"
            }else{
                urlComponents.query = "\(Constants.PARAM_STRING)=\(searchTitle)&\(Constants.PARAM_API_KEY)=\(Constants.OMDB_API_KEY)"
            }
            print("A")
            
            if let url = urlComponents.url {
                print("B")
                
                dataTask = defaultSession.dataTask(with: url, completionHandler: {
                    (data, response, error) in
                    
                    print("C")
                    defer{
                        self.dataTask = nil
                    }
                    
                    completion(data, response, error)
                    
//                    print("C")
//                    defer{
//                        self.dataTask = nil
//                    }
//                    if(error != nil){
//
//                    }else{
//                        if let dataFetched = data {
//                            let responseObtained = response as? HTTPURLResponse
//
//                            if(responseObtained?.statusCode == 200){
//
//                                let json = JSON(dataFetched)
//                            }
//                        }
//                    }
                })
            }
        }
        dataTask?.resume()
    }
}
