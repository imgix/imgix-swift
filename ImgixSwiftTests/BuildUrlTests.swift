//
//  BuildUrlTests.swift
//  imgix-swift
//
//  Created by Paul Straw on 7/4/16.
//
//

import XCTest
import ImgixSwift

class BuildUrlTests: XCTestCase {
    var client: ImgixClient!

    override func setUp() {
        super.setUp()
        
        client = ImgixClient.init(host: "paulstraw.imgix.net")
        client.includeLibraryParam = false
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBuildUrlWithoutParams() {
        let generatedUrl = client.buildUrl("1.jpg")
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg"
        
        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
    
    func testBuildUrlWithoutParamsAndIncludeLibraryParam() {
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
    
    func testQueryStringKeyEscaping() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["hello world": "interesting"])
        let expectedQuery = "hello%20world=interesting"
        
        XCTAssert(generatedUrl.query == expectedQuery)
    }
    
    func testQueryStringValueEscaping() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["txt": "/foo'> <script>alert('hacked')</script><"])
        let expectedQuery = "txt=%2Ffoo'%3E%20%3Cscript%3Ealert('hacked')%3C%2Fscript%3E%3C"
        
        XCTAssert(generatedUrl.query == expectedQuery)
    }
    
    func testBase64ParamVariantsAreBase64Encoded() {
        let generatedUrl = client.buildUrl("~text", params: ["txt64": "I cannøt belîév∑ it wors! 😱"])
        let expectedQuery = "txt64=SSBjYW5uw7h0IGJlbMOuw6l24oiRIGl0IHdvcu-jv3MhIPCfmLE"
        
        XCTAssert(generatedUrl.query == expectedQuery)
    }

}
