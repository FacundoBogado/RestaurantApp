//
//  RestaurantControllerSpy.swift
//  RestaurantAppTests
//
//  Created by Facu Bogado on 10/05/2022.
//

import Foundation
@testable import RestaurantApp
class RestaurantControllerSpy: RestaurantProtocolController {
    var getRestaurantDataInvoked = false
    func getRestaurantData(completion: @escaping (RestaurantResult) -> ()) {
        getRestaurantDataInvoked = true
    }
}
