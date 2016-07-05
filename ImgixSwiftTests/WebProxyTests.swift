//
//  WebProxyTests.swift
//  imgix-swift
//
//  Created by Paul Straw on 7/5/16.
//
//

import XCTest
import ImgixSwift

class WebProxyTests: XCTestCase {

    var client: ImgixClient!
    
    override func setUp() {
        super.setUp()
        
        client = ImgixClient.init(host: "imgix-library-web-proxy-test-source.imgix.net", secureUrlToken: "qN5VOqaLGQUFzETO")
        client.includeLibraryParam = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFullyQualifiedPath() {
        let generatedUrl = client.buildUrl("http://files.paulstraw.com/pixelpaul.png")
        let expectedUrl = "https://imgix-library-web-proxy-test-source.imgix.net/http%3A%2F%2Ffiles.paulstraw.com%2Fpixelpaul.png?s=1c57b8db669c9b265b4dd42f3b2de37a"
        
        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
    
    func testEscapesFullyQualifiedPath() {
        let generatedUrl = client.buildUrl("http://files.paulstraw.com/pixel>paul.png")
        let expectedUrl = "https://imgix-library-web-proxy-test-source.imgix.net/http%3A%2F%2Ffiles.paulstraw.com%2Fpixel%3Epaul.png?s=a9bbef784d922914d0a915dc9e218f6f"
        
        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
  
}
