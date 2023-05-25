//
//  NetworkManager.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import Foundation

/*
 Final class, created with a generic type that conforms to codable
 completion handler that is escaping, returns a Result(T or NetworkError)
 
 conforming to any network api call as long as object has codable protocol
 */
final class NetworkManager<T: Decodable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void){
        
        //create url session and data task
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //error is not nil
            guard error == nil else {
                print(String(describing: error!))
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            
            //statusCode == 200 means getting some actual result
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
            
            print(data)
            
        }.resume()
        
    }
}


enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String) //associated value of string
    case decodingError(err: String)
}
