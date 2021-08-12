//
//  NetworkHandler.swift
//  NewsFeed
//
//  Created by Vishwanath on 11/08/21.
//

import Foundation
/// URL Checker
enum URLError : Error {
    /// Check if the given url  is incorrect
    case unformatedURL
    /// Check if the data is present ot not
    case dataNotFound
}
/**
 * URL Constants
 */
class URLConstants {
    static let factsURL = "https://newsapi.org/v2/everything?q=tesla&from=2021-07-11&sortBy=publishedAt&apiKey=1eafa4963925472bb1530f2cbd89b24a"
}

/*
 * Network calls are made here and response is sent back via completion handler
 */
class Network {
    
    /// Get API Call
    static func getApiCallWithRequestString(requestString: String, completionBlock: @escaping((Result<Data, Error>) -> Void)) {
        
        guard let url = URL(string: requestString) else {
            completionBlock(.failure(URLError.unformatedURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (responseData, httpResponse, error) in
            
            if let err = error {
                completionBlock(.failure(err))
                return
            }
            
            guard let response = responseData else {
                completionBlock(.failure(URLError.dataNotFound))
                return
            }
            
            completionBlock(.success(response))
        }
        dataTask.resume();
    }
}
