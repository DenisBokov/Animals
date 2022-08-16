//
//  NetworkManager.swift
//  Animals
//
//  Created by Denis Bokov on 14.08.2022.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchAnimalImage(from url: String, complition: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            complition(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                complition(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                complition(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String, comlition: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            comlition(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                comlition(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    comlition(.success(type))
                }
            } catch {
                comlition(.failure(.decodingError))
            }
        }.resume()
    }
}
