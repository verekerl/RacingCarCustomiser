//
//  RacingCarCustomiserTests.swift
//  RacingCarCustomiserTests
//
//  Created by Luke Vereker on 12/01/2023.
//

import XCTest

class RacingCarCustomiserTests: XCTestCase {

    func testNewCarGivesMeACarWithAllAttributesSet() {
        //arrange
        let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        //assert
        XCTAssertEqual(car.make, "Mazda")
        XCTAssertEqual(car.model, "MX-5")
        XCTAssertEqual(car.topSpeed, 125)
        XCTAssertEqual(car.acceleration, 7.7)
        XCTAssertEqual(car.handling, 5)
        
    }
    
    func testDisplayAllCarStats() {
        //arrange
        let car = Car(make: "Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        let expected = """
        Make: Mazda
        Model: MX-5
        Top Speed: 125mph
        Acceleration (0-60): 7.7s
        Handling: 5
        """
        //arrange
        let actual = car.displayCarStats()
        //assert
        XCTAssertEqual(actual, expected)
    }

}
