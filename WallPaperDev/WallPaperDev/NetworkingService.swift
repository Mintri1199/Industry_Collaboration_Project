//
//  NetworkingService.swift
//  WallPaperDev
//
//  Created by Jamar Gibbs on 10/30/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

class NetworkingService {
    
    static let shared = NetworkingService()
    private init() {}

    func getData(parameters: [String : String], completion: @escaping (Data) -> () ) -> () {

        let baseURL = "https://api.unsplash.com/search/photos"
        var newURL = URLComponents(string: baseURL)
        newURL?.queryItems = []
        
        for param in parameters {
            newURL?.queryItems?.append(URLQueryItem(name: param.key, value: param.value))
        }
        
        guard let url = newURL?.url else {
            print("invalid url")
            return }
        
        var request = URLRequest(url: url)
//        request.addValue("Bearer \(APIKey.key)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {return}
            
            print(response.statusCode)
            print(url)
            
            guard error == nil else {
                print(error)
                return
            }
            guard let responseData = data else {
                print("missing data")
                return
            }
            completion(responseData)
            }.resume()
    }
    
    func getPhoto(from urlPath: String, completion: @escaping (Data) -> () ) {
        //        let url = URL(fileURLWithPath: urlPath)
        let url = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        //        request.addValue("Bearer \(APIKey.key)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {return}
            
            print(response.statusCode)
            
            guard error == nil else {
                print(error)
                return
            }
            guard let responseData = data else {
                print("missing data")
                return
            }
            print(data)
            completion(responseData)
            }.resume()
    }
    
}
