//
//  RestaurantControllerTests.swift
//  RestaurantAppTests
//
//  Created by Facu Bogado on 10/05/2022.
//

import Foundation
import XCTest
@testable import RestaurantApp

class RestaurantControllerTests: XCTestCase {
    var sut: RestaurantProtocolController!
    
    override func tearDown() {
        sut = nil
    }
    
    func test_whenControllerIscreated_getInfoIscalled() {
        givenController()
        whenFetchingData()
        theGetRestaurantDataIs_Invoked()
    }
}

private extension RestaurantControllerTests {
    // MARK: - Given
    func givenController() {
        sut = RestaurantControllerSpy()
    }
    // MARK: - When
    func whenFetchingData() {
        sut.getRestaurantData { result in
            return
        }
    }
    // MARK: - Then
    func theGetRestaurantDataIs_Invoked() {
        let controller = (sut as! RestaurantControllerSpy)
        XCTAssertTrue(controller.getRestaurantDataInvoked)
    }
}
