//
//  Animal.swift
//  Animals
//
//  Created by Denis Bokov on 12.08.2022.
//

import Foundation

struct Animal: Decodable {
    let name: String
    let latinName: String
    let animalType: String
    let activeTime: String
    let lengthMin: String
    let lengthMax: String
    let weightMin: String
    let weightMax: String
    let lifespan: String
    let habitat: String
    let diet: String
    let geoRange: String
    let imageLink: String
    
    var urlAdress: String {
        "https://zoo-animal-api.herokuapp.com/animals/rand/10"
    }
    
    var description: String {
        """
    Latin Name: \(latinName)
    Animal Type: \(animalType)
    Active Time: \(activeTime)
    Length Min: \(lengthMin)
    Length Max: \(lengthMax)
    Weigth Min: \(weightMin)
    Weigth Max: \(weightMax)
    Life Span: \(lifespan)
    Habitat: \(habitat)
    Diet: \(diet)
    Geo Range: \(geoRange)
    """
    }
}
