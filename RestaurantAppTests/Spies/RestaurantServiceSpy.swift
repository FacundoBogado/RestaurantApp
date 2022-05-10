//
//  RestaurantServiceSpy.swift
//  RestaurantAppTests
//
//  Created by Facu Bogado on 10/05/2022.
//

import Foundation
@testable import RestaurantApp
class RestaurantServiceSpy: ServiceProtocol {
    var fetchDataInvoked = false
    func fetchData(completion: @escaping (Result<RestaurantResult, Error>) -> Void) {
        fetchDataInvoked = true
    }
}
