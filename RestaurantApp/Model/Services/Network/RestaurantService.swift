//
//  RestaurantService.swift
//  RestaurantApp
//
//  Created by Facu Bogado on 09/05/2022.
//

import Foundation

private struct Constants {
    static let url = "https://alanflament.github.io/TFTest/test.json"
}

protocol ServiceProtocol {
    func fetchData(completion: @escaping (Result<RestaurantResult, Error>) -> Void)
}

final class RestaurantService: ServiceProtocol {
    func fetchData(completion: @escaping (Result<RestaurantResult, Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: Constants.url)!,
                                   completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            var result: RestaurantResult?
            do {
                result = try JSONDecoder().decode(RestaurantResult.self, from: data)
            } catch {
                print("Parsing error")
            }

            guard let restaurants = result else {
                return
            }
            return completion(.success(restaurants))
        }).resume()
    }
}
