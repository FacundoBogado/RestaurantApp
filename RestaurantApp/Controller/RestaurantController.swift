//
//  RestaurantController.swift
//  RestaurantApp
//
//  Created by Facu Bogado on 09/05/2022.
//

import Foundation
import Dispatch

protocol RestaurantProtocolController {
    func getRestaurantData(completion: @escaping (RestaurantResult) -> ())
}

final class RestaurantController: RestaurantProtocolController {
    private var service: RestaurantService
    
    init(service: RestaurantService = RestaurantService()) {
        self.service = service
    }
    
    func getRestaurantData(completion: @escaping (RestaurantResult) -> ()) {
        service.fetchData() { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let restaurants):
                    completion(restaurants)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
