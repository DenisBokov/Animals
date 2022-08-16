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
    
    init(animalData: [String: Any]) {
        name = animalData["name"] as? String ?? ""
        latinName = animalData["latinName"] as? String ?? ""
        animalType = animalData["animalType"] as? String ?? ""
        activeTime = animalData["activeTime"] as? String ?? ""
        lengthMin = animalData["lengthMin"] as? String ?? ""
        lengthMax = animalData["lengthMax"] as? String ?? ""
        weightMin = animalData["weightMin"] as? String ?? ""
        weightMax = animalData["weightMax"] as? String ?? ""
        lifespan = animalData["lifespan"] as? String ?? ""
        habitat = animalData["habitat"] as? String ?? ""
        diet = animalData["diet"] as? String ?? ""
        geoRange = animalData["geoRange"] as? String ?? ""
        imageLink = animalData["imageLink"] as? String ?? ""
    }
    
    static func getAnimals(from value: Any) -> [Animal] {
        guard let animalsData = value as? [[String: Any]] else { return [] }
        var animals: [Animal] = []
        for animalData in animalsData {
            let animal = Animal(animalData: animalData)
            animals.append(animal)
        }
        return animals
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case latinName = "latin_name"
        case animalType = "animal_type"
        case activeTime = "active_time"
        case lengthMin = "length_min"
        case lengthMax = "length_max"
        case weightMin = "weight_min"
        case weightMax = "weight_max"
        case lifespan = "lifespan"
        case habitat = "habitat"
        case diet = "diet"
        case geoRange = "geo_range"
        case imageLink = "image_link"
    }
}

enum Link: String {
    case url = "https://zoo-animal-api.herokuapp.com/animals/rand/10"
}
