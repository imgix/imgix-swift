//
//  buildUrlTests.swift
//  imgix-swift
//
//  Created by Paul Straw on 7/4/16.
//
//

import XCTest
import ImgixSwift

class buildUrlTests: XCTestCase {
    var client: ImgixClient!

    override func setUp() {
        super.setUp()
        
        client = ImgixClient.init(host: "paulstraw.imgix.net")
        client.includeLibraryParam = false
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBuildUrlWithNoParams() {
        let generatedUrl = client.buildUrl("1.jpg")
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg"
        
        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
    
    func testBuildUrlWithNoParamsAndIncludeLibraryParam() {
        client.includeLibraryParam = true
        
        let generatedUrl = client.buildUrl("1.jpg")
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?ixlib=swift-" + ImgixClient.version
        
        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
    
    func testBuildUrlWithOneParam() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["w": 400])
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?w=400"
        
        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
    
    func testBuildUrlWithMultipleParams() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["w": 400, "flip": "v"])
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?flip=v&w=400"
        
        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

}
