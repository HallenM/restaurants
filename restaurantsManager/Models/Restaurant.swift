//
//  Restaurants.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation
import RealmSwift

struct Restaurant: Codable {
    let address: String?
    let description: String?
    let id: Int
    let imagePaths: [String]?
    let location: Location?
    let name: String?
    let rating: Float?
}

struct Location: Codable {
    let lat: Float?
    let lon: Float?
}

class RestaurantRealm: Object {
    @objc dynamic var address: String?
    @objc dynamic var descriptionRestaurant: String?
    @objc dynamic var id = 0
    var imagePaths = List<String>()
    @objc dynamic var locationLat = 0.0
    @objc dynamic var locationLon = 0.0
    @objc dynamic var name: String?
    @objc dynamic var rating = 0.0
    
    func objectToStructure() -> Restaurant {
        let location = Location(lat: Float(self.locationLat), lon: Float(self.locationLon))
        
        var list = [String]()
        for item in self.imagePaths {
            list.append(item)
        }
        
        let restaurant = Restaurant(
            address: self.address,
            description: self.descriptionRestaurant,
            id: self.id,
            imagePaths: list,
            location: location,
            name: self.name,
            rating: Float(self.rating)
        )
        return restaurant
    }
    
    func structToObject(structure: Restaurant) -> RestaurantRealm{
        let list = List<String>()
        
        if let imagePaths = structure.imagePaths {
            for item in imagePaths {
                list.append(item)
            }
        }
        
        let object = RestaurantRealm()
        object.address = structure.address
        object.descriptionRestaurant = structure.description
        object.id = structure.id
        object.imagePaths = list
        object.locationLat = Double(structure.location?.lat ?? 0.0)
        object.locationLon = Double(structure.location?.lon ?? 0.0)
        object.name = structure.name
        object.rating = Double(structure.rating ?? 0.0)
        
        return object
    }
}
