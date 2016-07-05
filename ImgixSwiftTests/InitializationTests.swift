//
//  InitializationTests.swift
//  ImgixSwiftTests
//
//  Created by Paul Straw on 7/4/16.
//
//

import XCTest
import ImgixSwift

class InitializationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHost() {
        let client = ImgixClient.init(host: "paulstraw.imgix.net")
        
        XCTAssert(client.host == "paulstraw.imgix.net")
    }
    
    func testDefaultsToHttpsUrls() {
        let client = ImgixClient.init(host: "paulstraw.imgix.net")
        
        XCTAssert(client.useHttps == true)
    }
    
    func testSettingHttpUrls() {
        let client = ImgixClient.init(host: "paulstraw.imgix.net", useHttps: false)
        
        XCTAssert(client.useHttps == false)
    }
    
    func testSettingSecureUrlToken() {
        let client = ImgixClient.init(host: "paulstraw.imgix.net", secureUrlToken: "loreM")
        
        XCTAssert(client.secureUrlToken == "loreM")
    }
}
