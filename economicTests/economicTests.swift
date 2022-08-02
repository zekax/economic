//
//  economicTests.swift
//  economicTests
//
//  Created by José Rodrigues on 31/07/2022.
//

import XCTest
@testable import economic

class economicTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAFileSave() throws {
        let image = UIImage(named: "matchpitch")
        let fileName = Utils.savePNGImage(image: image ?? UIImage(), filename: "matchpitch.png")
        print(fileName)
        XCTAssertNotNil(image)
        XCTAssertTrue(!fileName.isEmpty)
    }
    
    func testBFileLoad() throws {
        let image = Utils.loadPNGImage(filename: "matchpitch.png")
        XCTAssertNotNil(image)
    }
    
    func testCurrency() throws {
        let euro =  Currency(name: "Euro", code: "EUR", symbol: "€")
        XCTAssertNotNil(Currency.allCurrencies)
        XCTAssertEqual(Currency.getSymbol(forCurrencyCode: "EUR"), "€")
        XCTAssertEqual(Currency.getCurrency(forCurrencyCode: "EUR"), euro)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
