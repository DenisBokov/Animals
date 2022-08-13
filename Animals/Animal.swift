//
//  Animal.swift
//  Animals
//
//  Created by Denis Bokov on 12.08.2022.
//

import Foundation

struct Animal: Decodable {
    let name: String
    let latin_name: String
    let animal_type: String
    let active_time: String
    let length_min: String
    let length_max: String
    let weight_min: String
    let weight_max: String
    let lifespan: String
    let habitat: String
    let diet: String
    let geo_range: String
    let image_link: String
}
