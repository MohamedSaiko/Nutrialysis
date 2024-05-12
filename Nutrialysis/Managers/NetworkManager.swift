//
//  NetworkManager.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 24.04.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError
    case decodingError
    case encodingError
    case unknownError(Error)
    case noResponse
}

struct NetworkManager {
    func loadData<T: Decodable>(withURL urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = URL(string: urlString)
        
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(appID, forHTTPHeaderField: "x-app-id")
        request.setValue(apiKey, forHTTPHeaderField: "x-app-key")
        request.setValue("0", forHTTPHeaderField: "x-remote-user-id")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.noResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let jsonFood = try decoder.decode(T.self, from: data)
                completion(.success(jsonFood))
            }
            catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
    
    func sendFoodName<T: Decodable>(foodName: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = URL(string: foodNutrientsURL)
        
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let foodData: [String : String] = [
            "query": foodName
        ]
        
        guard let uploadData = try? JSONEncoder().encode(foodData) else {
            completion(.failure(NetworkError.encodingError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(appID, forHTTPHeaderField: "x-app-id")
        request.setValue(apiKey, forHTTPHeaderField: "x-app-key")
        request.setValue("0", forHTTPHeaderField: "x-remote-user-id")
        request.httpBody = uploadData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.noResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let jsonNutrients = try decoder.decode(T.self, from: data)
                completion(.success(jsonNutrients))
            }
            catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
}
