//
//  SignatureTests.swift
//  imgix-swift
//
//  Created by Paul Straw on 7/5/16.
//
//

import XCTest
import ImgixSwift

class SignatureTests: XCTestCase {
    var client: ImgixClient!
    
    override func setUp() {
        super.setUp()
        
        client = ImgixClient.init(
            host: "imgix-library-secure-test-source.imgix.net",
            secureUrlToken: "EHFQXiZhxP4wA2c4"
        )
        
        client.includeLibraryParam = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSigningWithoutParams() {
        let generatedUrl = client.buildUrl("dog.jpg")
        let expectedQuery = "s=2b0bc99b1042e3c1c9aae6598acc3def"
        
        XCTAssert(generatedUrl.query == expectedQuery)
    }
    
    func testSigningWithOneParam() {
        let generatedUrl = client.buildUrl("dog.jpg", params: ["bri": 50])
        let expectedQuery = "bri=50&s=3b293930d9c288fb788657fd9ed8164f"
        
        XCTAssert(generatedUrl.query == expectedQuery)
    }
    
    func testSigningWithMultipleParams() {
        let generatedUrl = client.buildUrl("dog.jpg", params: ["bri": 50, "con": 20])
        let expectedQuery = "bri=50&con=20&s=30c03db96a644d5ce6e85022be191248"
        
        XCTAssert(generatedUrl.query == expectedQuery)
    }
    
}

