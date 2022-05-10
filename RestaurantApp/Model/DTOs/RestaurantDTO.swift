//
//  RestaurantDTO.swift
//  RestaurantApp
//
//  Created by Facu Bogado on 09/05/2022.
//

import Foundation

// MARK: - Welcome
struct RestaurantResult: Codable {
    let data: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let name, uuid, servesCuisine: String
    let priceRange: Int
    let currenciesAccepted: String
    let address: Address
    let aggregateRatings: AggregateRatings
    let mainPhoto: MainPhoto?
    let bestOffer: BestOffer
}

// MARK: - Address
struct Address: Codable {
    let street, postalCode: String
    let locality: String
    let country: String
}

// MARK: - AggregateRatings
struct AggregateRatings: Codable {
    let thefork, tripadvisor: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let ratingValue: Double
    let reviewCount: Int
}

// MARK: - BestOffer
struct BestOffer: Codable {
    let name: String
    let label: String
}

// MARK: - MainPhoto
struct MainPhoto: Codable {
    let source, photo612X344, photo480X270, photo240X135: String
    let photo664X374, photo1350X759, photo160X120, photo80X60: String
    let photo92X92, photo184X184: String

    private enum CodingKeys: String, CodingKey {
        case source
        case photo612X344 = "612x344"
        case photo480X270 = "480x270"
        case photo240X135 = "240x135"
        case photo664X374 = "664x374"
        case photo1350X759 = "1350x759"
        case photo160X120 = "160x120"
        case photo80X60 = "80x60"
        case photo92X92 = "92x92"
        case photo184X184 = "184x184"
    }
}
