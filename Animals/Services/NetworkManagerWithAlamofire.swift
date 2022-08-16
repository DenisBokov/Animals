//
//  NetworkManagerWithAlamofire.swift
//  Animals
//
//  Created by Denis Bokov on 16.08.2022.
//

import Foundation
import Alamofire


class NetworkManagerWithAlamofire {
    static let shared = NetworkManagerWithAlamofire()
    
    private init() {}
    
    func fetchAnimals(from url: String, complition: @escaping(Result<[Animal], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let animals = Animal.getAnimals(from: value)
                    complition(.success(animals))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, complition: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    complition(.success(data))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
}
