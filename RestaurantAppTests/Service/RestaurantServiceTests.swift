//
//  RestaurantServiceTests.swift
//  RestaurantAppTests
//
//  Created by Facu Bogado on 10/05/2022.
//

import Foundation
import XCTest
@testable import RestaurantApp

class RestaurantServiceTests : XCTestCase {
    var sut: ServiceProtocol!

    override func tearDown() {
        sut = nil
    }

    func test_whenServiceIsCreated_FetchDataUsCalled() {
        givenService()
        whenFetchingData()
        thenFetchDataIs_Invoked()
    }
}

private extension RestaurantServiceTests {
    // MARK: - Given
    func givenService() {
        sut = RestaurantServiceSpy()
    }
    // MARK: - When
    func whenFetchingData() {
        sut.fetchData { result in
            return
        }
    }
    // MARK: - Then
    func thenFetchDataIs_Invoked() {
        let controller = (sut as! RestaurantServiceSpy)
        XCTAssertTrue(controller.fetchDataInvoked)
    }
}
